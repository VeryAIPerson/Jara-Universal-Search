package com.jara.jara_universal_search

import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/**
 * Share-sheet intake for the filters declared in AndroidManifest.xml.
 *
 * Two delivery paths, one payload shape:
 *  - cold start: the share intent is already on the Activity before Dart
 *    exists, so it is parked in [pendingShare] and handed over when Dart
 *    asks via `getInitialShare`;
 *  - warm: the app is running, [onNewIntent] pushes `onShare` straight
 *    down the channel.
 *
 * Payload: `{ "type": "text"|"url"|"image", "value": String,
 * "extras": [String] }` — see lib/core/data/share_intake.dart, which is
 * the Dart half of this same contract.
 *
 * Image URIs are passed through as strings. Reading their bytes here would
 * duplicate work the indexer will do, and the read grant that came with
 * the intent is scoped to this task — it dies with the process, so the
 * copy has to happen during the session that received the share, not here
 * at intake time.
 */
class MainActivity : FlutterActivity() {

    private var channel: MethodChannel? = null
    private var pendingShare: Map<String, Any?>? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        // Before super: super.onCreate() attaches the engine, which calls
        // configureFlutterEngine() below, and that is already allowed to
        // answer getInitialShare.
        pendingShare = sharePayload(intent)
        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val shareChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL_NAME,
        )
        shareChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                METHOD_INITIAL -> {
                    result.success(pendingShare)
                    // One delivery per launch: a hot restart must not
                    // re-open the capture screen for an old share.
                    pendingShare = null
                }
                else -> result.notImplemented()
            }
        }
        channel = shareChannel
    }

    override fun onDestroy() {
        channel?.setMethodCallHandler(null)
        channel = null
        super.onDestroy()
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        // Keep getIntent() truthful for anything that reads it later.
        this.intent = intent
        val payload = sharePayload(intent) ?: return
        val shareChannel = channel
        if (shareChannel == null) {
            // Engine not attached yet — fall back to the cold path.
            pendingShare = payload
            return
        }
        shareChannel.invokeMethod(METHOD_SHARE, payload)
    }

    private fun sharePayload(intent: Intent?): Map<String, Any?>? {
        if (intent == null) return null
        val mimeType = intent.type ?: return null
        return when (intent.action) {
            Intent.ACTION_SEND -> when {
                mimeType.startsWith("text/") -> textPayload(intent)
                mimeType.startsWith("image/") -> singleImagePayload(intent)
                else -> null
            }
            Intent.ACTION_SEND_MULTIPLE ->
                if (mimeType.startsWith("image/")) multiImagePayload(intent)
                else null
            else -> null
        }
    }

    private fun textPayload(intent: Intent): Map<String, Any?>? {
        val text = intent.getStringExtra(Intent.EXTRA_TEXT)?.trim()
        if (text.isNullOrEmpty()) return null
        val type = if (isWebUrl(text)) TYPE_URL else TYPE_TEXT
        return payload(type, text, emptyList(), subjectOf(intent))
    }

    /**
     * EXTRA_SUBJECT usually carries the page title next to an EXTRA_TEXT
     * URL — the best title suggestion any app will ever hand us.
     */
    private fun subjectOf(intent: Intent): String? =
        intent.getStringExtra(Intent.EXTRA_SUBJECT)
            ?.trim()
            ?.takeIf { it.isNotEmpty() }

    /**
     * True only when the whole payload is one http(s) URL. "Read this
     * https://x" stays a text note on purpose — the sentence around the
     * link is the part worth remembering.
     */
    private fun isWebUrl(text: String): Boolean {
        val uri = Uri.parse(text)
        val scheme = uri.scheme?.lowercase() ?: return false
        if (scheme != "http" && scheme != "https") return false
        return !uri.host.isNullOrEmpty()
    }

    private fun singleImagePayload(intent: Intent): Map<String, Any?>? {
        val uri = intent.streamExtra() ?: return null
        return payload(
            TYPE_IMAGE, uri.toString(), emptyList(), subjectOf(intent))
    }

    private fun multiImagePayload(intent: Intent): Map<String, Any?>? {
        val uris = intent.streamExtras()
            .map { it.toString() }
            .filter { it.isNotEmpty() }
        if (uris.isEmpty()) return null
        return payload(
            TYPE_IMAGE, uris.first(), uris.drop(1), subjectOf(intent))
    }

    private fun payload(
        type: String,
        value: String,
        extras: List<String>,
        subject: String?,
    ): Map<String, Any?> = mapOf(
        "type" to type,
        "value" to value,
        "extras" to extras,
        "subject" to subject,
    )

    @Suppress("DEPRECATION")
    private fun Intent.streamExtra(): Uri? =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            getParcelableExtra(Intent.EXTRA_STREAM, Uri::class.java)
        } else {
            getParcelableExtra<Uri>(Intent.EXTRA_STREAM)
        }

    @Suppress("DEPRECATION")
    private fun Intent.streamExtras(): List<Uri> {
        val uris = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            getParcelableArrayListExtra(Intent.EXTRA_STREAM, Uri::class.java)
        } else {
            getParcelableArrayListExtra<Uri>(Intent.EXTRA_STREAM)
        }
        return uris ?: emptyList()
    }

    private companion object {
        const val CHANNEL_NAME = "jara/share_intake"
        const val METHOD_INITIAL = "getInitialShare"
        const val METHOD_SHARE = "onShare"
        const val TYPE_TEXT = "text"
        const val TYPE_URL = "url"
        const val TYPE_IMAGE = "image"
    }
}
