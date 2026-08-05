import '../core/models/memory_item.dart';
import 'strings.dart';

class JaraStringsIt extends JaraStrings {
  const JaraStringsIt();

  @override
  String get appName => 'JARA Universal Search';
  @override
  String get tagline => 'Tutto ciò che conta. Un’unica ricerca.';

  @override
  String get onb1Title => 'Tutto ciò che conta.\nUn’unica ricerca.';
  @override
  String get onb1Body =>
      'Trova i tuoi file, le foto, le note e i link in un’unica memoria '
      'personale.';
  @override
  String get onb2Title => 'Privacy fin dall’inizio';
  @override
  String get onb2Body =>
      'I tuoi contenuti vengono elaborati sul dispositivo quando '
      'possibile — il controllo resta sempre a te.';
  @override
  String get onb3Title => 'Salva una volta.\nTrova in qualsiasi momento.';
  @override
  String get onb3Body =>
      'Condividi da qualsiasi app con JARA, poi ritrovalo quando vuoi, '
      'con le tue parole.';
  @override
  String get onbPrimaryCta => 'Crea la mia memoria';
  @override
  String get onbSecondaryCta => 'Esplora la demo';
  @override
  String get onbSkip => 'Salta';

  @override
  String greetingMorning(String name) =>
      name.isEmpty ? 'Buongiorno' : 'Buongiorno, $name';
  @override
  String greetingDay(String name) =>
      name.isEmpty ? 'Buon pomeriggio' : 'Buon pomeriggio, $name';
  @override
  String greetingEvening(String name) =>
      name.isEmpty ? 'Buonasera' : 'Buonasera, $name';
  @override
  String get searchTitle => 'Trova tutto\nciò che hai salvato.';
  @override
  List<String> get searchHints => const [
        'Trova il documento del mio viaggio a Londra',
        'Mostrami gli screenshot con i dettagli di pagamento',
        'Cosa avevo salvato sui prezzi di VoxBridge?',
        'Trova il mio appuntamento dal dottore',
        'Mostrami le foto con un passaporto',
      ];
  @override
  String get filterAll => 'Tutti';

  @override
  String typeLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Documento',
        MemoryType.photo => 'Foto',
        MemoryType.screenshot => 'Screenshot',
        MemoryType.note => 'Nota',
        MemoryType.link => 'Link',
        MemoryType.audio => 'Audio',
        MemoryType.calendar => 'Calendario',
        MemoryType.email => 'Email',
        MemoryType.chat => 'Chat',
      };

  @override
  String typePluralLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Documenti',
        MemoryType.photo => 'Foto',
        MemoryType.screenshot => 'Screenshot',
        MemoryType.note => 'Note',
        MemoryType.link => 'Link',
        MemoryType.audio => 'Audio',
        MemoryType.calendar => 'Calendario',
        MemoryType.email => 'Email',
        MemoryType.chat => 'Chat',
      };

  @override
  String get sourcesSection => 'La tua memoria';
  @override
  String get recentSearches => 'Ricerche recenti';
  @override
  String get recentlySaved => 'Salvato di recente';
  @override
  String get suggestedSearches => 'Prova a chiedere';
  @override
  String get seeAll => 'Vedi tutto';
  @override
  String get memoryStatusTitle => 'La mia memoria';
  @override
  String memoryStatusItems(int items, int collections) =>
      '${items == 1 ? '1 elemento' : '$items elementi'} · '
      '${collections == 1 ? '1 raccolta' : '$collections raccolte'}';
  @override
  String memoryStatusFree(String free) => free;
  @override
  String indexedAgo(String ago) => 'Indicizzato $ago';
  @override
  String newItemsThisWeek(int count) => count == 1
      ? '+1 nuovo questa settimana'
      : '+$count nuovi questa settimana';

  @override
  String get suggestionsHistory => 'Recenti';
  @override
  String get suggestionsSmart => 'Suggerimenti';

  @override
  String resultsCount(int count, String elapsed) =>
      '${count == 1 ? '1 risultato' : '$count risultati'} · $elapsed';
  @override
  String get bestMatch => 'Corrispondenza migliore';
  @override
  String get smartSummaryTitle => 'Riepilogo intelligente';
  @override
  String basedOnItems(int count) => count == 1
      ? 'Basato su 1 elemento salvato'
      : 'Basato su $count elementi salvati';
  @override
  String get viewSources => 'Vedi le fonti';
  @override
  String get refineSearch => 'Affina la ricerca';
  @override
  String get saveAnswer => 'Salva la risposta';
  @override
  String get copied => 'Copiato';
  @override
  String get sortRecent => 'Più recente';
  @override
  String get sortRelevance => 'Corrispondenza migliore';

  @override
  String get actionOpen => 'Apri';
  @override
  String get actionPreview => 'Anteprima';
  @override
  String get actionShare => 'Condividi';
  @override
  String get actionPin => 'Fissa';
  @override
  String get actionUnpin => 'Rimuovi fissaggio';
  @override
  String get actionAddTag => 'Aggiungi etichetta';
  @override
  String get actionSaveToCollection => 'Salva in una raccolta';
  @override
  String get actionAskAbout => 'Fai una domanda su questo';
  @override
  String get actionDelete => 'Elimina dalla memoria';
  @override
  String get actionOpenOriginal => 'Apri originale';
  @override
  String get actionAskJara => 'Chiedi a JARA';

  @override
  String get detailRelated => 'Ricordi correlati';
  @override
  String get detailInCollection => 'Raccolta';
  @override
  String get detailTags => 'Etichette';
  @override
  String get detailPeople => 'Persone';
  @override
  String get detailSource => 'Fonte';
  @override
  String get detailAskPlaceholder => 'Fai una domanda su questo ricordo…';

  @override
  String get addTitle => 'Aggiungi a JARA';
  @override
  String get addScanDocument => 'Scansiona documento';
  @override
  String get addUploadFile => 'Carica file';
  @override
  String get addPhoto => 'Aggiungi foto';
  @override
  String get addScreenshot => 'Aggiungi screenshot';
  @override
  String get addVoiceNote => 'Registra nota vocale';
  @override
  String get addPasteText => 'Incolla testo';
  @override
  String get addSaveLink => 'Salva link';
  @override
  String get addCreateNote => 'Crea nota';
  @override
  String get addConnectAccount => 'Collega account';
  @override
  String get addImportCalendar => 'Importa calendario';
  @override
  String get addSuccessTitle => 'Salvato nella tua memoria';
  @override
  String get addSuccessSearchNow => 'Cercalo ora';
  @override
  String get addSuggestedTitle => 'Titolo suggerito';
  @override
  String get addSuggestedTags => 'Etichette suggerite';
  @override
  String get addCollection => 'Raccolta';
  @override
  String get addSaveInstantly => 'Salva all’istante';
  @override
  String get addSave => 'Salva';

  @override
  String get memoryTitle => 'Memoria';
  @override
  String get memoryAll => 'Tutti i ricordi';
  @override
  String get memoryPinned => 'Fissati';
  @override
  String get memoryRecent => 'Recenti';
  @override
  String get memoryTimeline => 'Cronologia';
  @override
  String get collectionsTitle => 'Raccolte';
  @override
  String collectionItems(int count) =>
      count == 1 ? '1 elemento' : '$count elementi';
  @override
  String updatedAgo(String ago) => 'Aggiornato $ago';

  @override
  String get connectionsTitle => 'Connessioni';
  @override
  String get connectionsSubtitle =>
      'Scegli cosa può indicizzare JARA. Puoi disconnetterti quando '
      'vuoi.';
  @override
  String get connectionConnected => 'Connesso';
  @override
  String get connectionSyncing => 'Sincronizzazione…';
  @override
  String get connectionDisconnected => 'Non connesso';
  @override
  String get connectionAttention => 'Richiede attenzione';
  @override
  String get connectionConnect => 'Connetti';
  @override
  String get connectionDisconnect => 'Disconnetti';
  @override
  String get connectionReindex => 'Reindicizza';
  @override
  String lastSynced(String ago) => 'Sincronizzato $ago';

  @override
  String get privacyTitle => 'Centro privacy';
  @override
  String get privacyLocalActive => 'Elaborazione locale attiva';
  @override
  String get privacyCloudOff => 'Intelligenza cloud disattivata';
  @override
  String get privacyCloudOn => 'Intelligenza cloud attivata';
  @override
  String get privacyOnDevice => 'Resta su questo dispositivo';
  @override
  String get privacyOnDeviceBody =>
      'Il tuo indice, le anteprime e la cronologia di ricerca sono '
      'salvati sul tuo dispositivo.';
  @override
  String get privacyCloudSection => 'Inviato al cloud';
  @override
  String get privacyCloudBody =>
      'Niente, a meno che tu non attivi l’Intelligenza cloud per '
      'risposte più complete.';
  @override
  String get privacyLocalAi => 'IA sul dispositivo';
  @override
  String get privacyCloudAi => 'Intelligenza cloud';
  @override
  String get privacyAppLock => 'Blocco app';
  @override
  String get privacyBiometric => 'Face ID / Touch ID';
  @override
  String get privacySensitive => 'Protezione dei contenuti sensibili';
  @override
  String get privacyExport => 'Esporta i miei dati';
  @override
  String get privacyClearHistory => 'Cancella cronologia di ricerca';
  @override
  String get privacyDeleteAll => 'Elimina tutti i dati';
  @override
  String get privacyDeleteConfirmTitle => 'Eliminare tutto?';
  @override
  String get privacyDeleteConfirmBody =>
      'Questa azione rimuove l’intero indice della tua memoria da '
      'questo dispositivo. Gli originali nelle tue app non vengono '
      'modificati.';
  @override
  String get cancel => 'Annulla';
  @override
  String get confirmDelete => 'Elimina';

  @override
  String get settingsTitle => 'Profilo';
  @override
  String get settingsTheme => 'Tema';
  @override
  String get settingsThemeDark => 'Scuro';
  @override
  String get settingsThemeLight => 'Chiaro';
  @override
  String get settingsThemeSystem => 'Sistema';
  @override
  String get settingsLanguage => 'Lingua';
  @override
  String get settingsSearchSources => 'Fonti di ricerca predefinite';
  @override
  String get settingsVoice => 'Ricerca vocale';
  @override
  String get settingsStorage => 'Archiviazione';
  @override
  String get settingsIndexing => 'Indicizzazione';
  @override
  String get settingsNotifications => 'Notifiche';
  @override
  String get settingsConnectedAccounts => 'Account collegati';
  @override
  String get settingsPrivacySecurity => 'Privacy e sicurezza';
  @override
  String get settingsSubscription => 'Abbonamento';
  @override
  String get settingsPremium => 'JARA Premium';
  @override
  String get settingsPremiumBody =>
      'Intelligenza cloud, connessioni illimitate e indicizzazione '
      'prioritaria.';

  @override
  String get back => 'Indietro';
  @override
  String get moreActions => 'Altre azioni';
  @override
  String get done => 'Fatto';
  @override
  String get apply => 'Applica';
  @override
  String get continueCta => 'Continua';
  @override
  String get searchAction => 'Cerca';
  @override
  String get sortBy => 'Ordina per';
  @override
  String get listening => 'In ascolto…';
  @override
  String get alwaysOn => 'Sempre attivo';
  @override
  String get clearDateFilter => 'Rimuovi filtro data';
  @override
  String get sectionGeneral => 'Generale';
  @override
  String get sectionIntelligence => 'Intelligenza';
  @override
  String get sectionData => 'Dati';
  @override
  String get productName => 'Universal Search';
  @override
  String get manualAddSource => 'Aggiunto da te';
  @override
  String get addedJustNow =>
      'Aggiunto proprio ora — JARA lo sta rendendo ricercabile.';

  @override
  String errorTitle(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'JARA ha bisogno del tuo consenso',
        JaraError.fileUnreadable => 'Questo file non si apre',
        JaraError.indexingFailed => 'L’indicizzazione si è interrotta',
        JaraError.accountDisconnected =>
          'L’account deve essere riconnesso',
        JaraError.noConnection => 'Sei offline',
        JaraError.localModelNotReady => 'Ancora in preparazione',
        JaraError.storageFull => 'Spazio esaurito su questo dispositivo',
        JaraError.sourceMissing => 'L’originale non c’è più',
        JaraError.generic => 'Qualcosa richiede un altro tentativo',
      };

  @override
  String errorBody(JaraError e) => switch (e) {
        JaraError.permissionDenied =>
          'Consenti l’accesso a questa fonte e sarà subito ricercabile.',
        JaraError.fileUnreadable =>
          'Il file potrebbe essere danneggiato o in un formato che JARA '
              'non sa ancora leggere.',
        JaraError.indexingFailed =>
          'Alcuni elementi non sono stati aggiunti. La tua memoria '
              'esistente non è stata modificata.',
        JaraError.accountDisconnected =>
          'Accedi di nuovo per mantenere aggiornati gli elementi di '
              'questo account.',
        JaraError.noConnection =>
          'La tua memoria sul dispositivo continua a funzionare. Le '
              'funzioni cloud riprenderanno automaticamente.',
        JaraError.localModelNotReady =>
          'La ricerca sul dispositivo sta completando la '
              'configurazione. La prima volta richiede un momento.',
        JaraError.storageFull =>
          'Libera un po’ di spazio, così JARA può completare '
              'l’indicizzazione.',
        JaraError.sourceMissing =>
          'Questo elemento è stato spostato o eliminato nella sua app '
              'originale.',
        JaraError.generic =>
          'Non è andato a buon fine. La tua memoria è al sicuro — '
              'riprova.',
      };

  @override
  String? errorCta(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'Apri impostazioni',
        JaraError.fileUnreadable => null,
        JaraError.indexingFailed => 'Riprova',
        JaraError.accountDisconnected => 'Riconnetti',
        JaraError.noConnection => null,
        JaraError.localModelNotReady => null,
        JaraError.storageFull => 'Gestisci archiviazione',
        JaraError.sourceMissing => 'Rimuovi dalla memoria',
        JaraError.generic => 'Riprova',
      };

  @override
  String get needsConnection => 'Richiede connessione';

  @override
  String get emptyResultsTitle => 'Ancora nessuna corrispondenza';
  @override
  String get emptyResultsBody =>
      'Prova a cambiare la data, la fonte o le parole usate.';
  @override
  String get emptyResultsAdjust => 'Modifica filtri';
  @override
  String get emptyResultsSearchAll => 'Cerca in tutta la memoria';
  @override
  String get emptyMemoryTitle => 'La tua memoria inizia qui';
  @override
  String get emptyMemoryBody =>
      'Aggiungi un file, uno screenshot, un link o una nota. JARA lo '
      'renderà ricercabile.';
  @override
  String get emptyMemoryCta => 'Aggiungi il primo ricordo';
  @override
  String get offlineLabel => 'La ricerca offline è attiva';
  @override
  String get offlineBody =>
      'La tua memoria sul dispositivo continua a funzionare. Le '
      'funzioni cloud riprenderanno automaticamente.';
  @override
  String get errorGenericTitle => 'Qualcosa richiede un altro tentativo';
  @override
  String get errorGenericBody =>
      'Non è andato a buon fine. La tua memoria è al sicuro — riprova.';
  @override
  String get retry => 'Riprova';

  @override
  String get shareTitle => 'Salva in JARA';
  @override
  String get shareSaveInstantly => 'Salva all’istante';
  @override
  String get shareReview => 'Rivedi i dettagli';
  @override
  String get shareSaved => 'Salvato nella tua memoria';

  @override
  String get today => 'Oggi';
  @override
  String get tomorrow => 'Domani';
  @override
  String get yesterday => 'Ieri';
  @override
  String daysAgo(int days) =>
      days == 1 ? '1 giorno fa' : '$days giorni fa';
  @override
  String inDays(int days) =>
      days == 1 ? 'tra 1 giorno' : 'tra $days giorni';
  @override
  String minutesAgo(int m) => m == 1 ? '1 minuto fa' : '$m minuti fa';
  @override
  String hoursAgo(int h) => h == 1 ? '1 ora fa' : '$h ore fa';
}
