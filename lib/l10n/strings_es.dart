import '../core/models/memory_item.dart';
import 'strings.dart';

class JaraStringsEs extends JaraStrings {
  const JaraStringsEs();

  @override
  String get appName => 'JARA Universal Search';
  @override
  String get tagline => 'Todo lo importante. Una sola búsqueda.';

  @override
  String get onb1Title => 'Todo lo importante.\nUna sola búsqueda.';
  @override
  String get onb1Body =>
      'Encuentra tus archivos, fotos, notas y enlaces en una sola memoria personal.';
  @override
  String get onb2Title => 'Privado por diseño';
  @override
  String get onb2Body =>
      'Tu contenido se procesa en tu dispositivo siempre que sea posible — el control siempre es tuyo.';
  @override
  String get onb3Title => 'Guarda una vez.\nEncuentra cuando quieras.';
  @override
  String get onb3Body =>
      'Comparte desde cualquier app a JARA y encuéntralo después con tus propias palabras.';
  @override
  String get onbPrimaryCta => 'Crear mi memoria';
  @override
  String get onbSecondaryCta => 'Explorar demo';
  @override
  String get onbSkip => 'Omitir';

  @override
  String greetingMorning(String name) =>
      name.isEmpty ? 'Buenos días' : 'Buenos días, $name';
  @override
  String greetingDay(String name) =>
      name.isEmpty ? 'Buenas tardes' : 'Buenas tardes, $name';
  @override
  String greetingEvening(String name) =>
      name.isEmpty ? 'Buenas noches' : 'Buenas noches, $name';
  @override
  String get searchTitle => 'Encuentra todo\nlo que has guardado.';
  @override
  List<String> get searchHints => const [
        'Busca el documento de mi viaje a Londres',
        'Muéstrame capturas de pantalla con datos de pago',
        '¿Qué guardé sobre los precios de VoxBridge?',
        'Busca mi cita con el médico',
        'Muéstrame fotos con un pasaporte',
      ];
  @override
  String get filterAll => 'Todo';

  @override
  String typeLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Documento',
        MemoryType.photo => 'Foto',
        MemoryType.screenshot => 'Captura de pantalla',
        MemoryType.note => 'Nota',
        MemoryType.link => 'Enlace',
        MemoryType.audio => 'Audio',
        MemoryType.calendar => 'Calendario',
        MemoryType.email => 'Correo',
        MemoryType.chat => 'Chat',
      };

  @override
  String typePluralLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Documentos',
        MemoryType.photo => 'Fotos',
        MemoryType.screenshot => 'Capturas de pantalla',
        MemoryType.note => 'Notas',
        MemoryType.link => 'Enlaces',
        MemoryType.audio => 'Audio',
        MemoryType.calendar => 'Calendario',
        MemoryType.email => 'Correos',
        MemoryType.chat => 'Chats',
      };

  @override
  String get sourcesSection => 'Tu memoria';
  @override
  String get recentSearches => 'Búsquedas recientes';
  @override
  String get recentlySaved => 'Guardado recientemente';
  @override
  String get suggestedSearches => 'Prueba a preguntar';
  @override
  String get seeAll => 'Ver todo';
  @override
  String get memoryStatusTitle => 'Mi memoria';
  @override
  String memoryStatusItems(int items, int collections) =>
      '${items == 1 ? '1 elemento' : '$items elementos'} · '
      '${collections == 1 ? '1 colección' : '$collections colecciones'}';
  @override
  String memoryStatusFree(String free) => free;
  @override
  String indexedAgo(String ago) => 'Indexado $ago';
  @override
  String newItemsThisWeek(int count) =>
      count == 1 ? '+1 nuevo esta semana' : '+$count nuevos esta semana';

  @override
  String get suggestionsHistory => 'Recientes';
  @override
  String get suggestionsSmart => 'Sugerencias';

  @override
  String resultsCount(int count, String elapsed) =>
      '${count == 1 ? '1 resultado' : '$count resultados'} · $elapsed';
  @override
  String get bestMatch => 'Mejor coincidencia';
  @override
  String get smartSummaryTitle => 'Resumen inteligente';
  @override
  String basedOnItems(int count) => count == 1
      ? 'Basado en 1 elemento guardado'
      : 'Basado en $count elementos guardados';
  @override
  String get viewSources => 'Ver fuentes';
  @override
  String get refineSearch => 'Refinar búsqueda';
  @override
  String get saveAnswer => 'Guardar respuesta';
  @override
  String get copied => 'Copiado';
  @override
  String get sortRecent => 'Más reciente';
  @override
  String get sortRelevance => 'Mejor coincidencia';

  @override
  String get actionOpen => 'Abrir';
  @override
  String get actionPreview => 'Vista previa';
  @override
  String get actionShare => 'Compartir';
  @override
  String get actionPin => 'Fijar';
  @override
  String get actionUnpin => 'Dejar de fijar';
  @override
  String get actionAddTag => 'Añadir etiqueta';
  @override
  String get actionSaveToCollection => 'Guardar en colección';
  @override
  String get actionAskAbout => 'Preguntar sobre esto';
  @override
  String get actionDelete => 'Eliminar de la memoria';
  @override
  String get actionOpenOriginal => 'Abrir original';
  @override
  String get actionAskJara => 'Preguntar a JARA';

  @override
  String get detailRelated => 'Recuerdos relacionados';
  @override
  String get detailInCollection => 'Colección';
  @override
  String get detailTags => 'Etiquetas';
  @override
  String get detailPeople => 'Personas';
  @override
  String get detailSource => 'Fuente';
  @override
  String get detailAskPlaceholder => 'Pregunta sobre este recuerdo…';

  @override
  String get addTitle => 'Añadir a JARA';
  @override
  String get addScanDocument => 'Escanear documento';
  @override
  String get addUploadFile => 'Subir archivo';
  @override
  String get addPhoto => 'Añadir foto';
  @override
  String get addScreenshot => 'Añadir captura de pantalla';
  @override
  String get addVoiceNote => 'Grabar nota de voz';
  @override
  String get addPasteText => 'Pegar texto';
  @override
  String get addSaveLink => 'Guardar enlace';
  @override
  String get addCreateNote => 'Crear nota';
  @override
  String get addConnectAccount => 'Conectar cuenta';
  @override
  String get addImportCalendar => 'Importar calendario';
  @override
  String get addSuccessTitle => 'Guardado en tu memoria';
  @override
  String get addSuccessSearchNow => 'Buscar ahora';
  @override
  String get addSuggestedTitle => 'Título sugerido';
  @override
  String get addSuggestedTags => 'Etiquetas sugeridas';
  @override
  String get addCollection => 'Colección';
  @override
  String get addSaveInstantly => 'Guardar al instante';
  @override
  String get addSave => 'Guardar';

  @override
  String get memoryTitle => 'Memoria';
  @override
  String get memoryAll => 'Todos los recuerdos';
  @override
  String get memoryPinned => 'Fijados';
  @override
  String get memoryRecent => 'Recientes';
  @override
  String get memoryTimeline => 'Cronología';
  @override
  String get collectionsTitle => 'Colecciones';
  @override
  String collectionItems(int count) =>
      count == 1 ? '1 elemento' : '$count elementos';
  @override
  String updatedAgo(String ago) => 'Actualizado $ago';

  @override
  String get connectionsTitle => 'Conexiones';
  @override
  String get connectionsSubtitle =>
      'Elige qué puede indexar JARA. Puedes desconectar en cualquier momento.';
  @override
  String get connectionConnected => 'Conectado';
  @override
  String get connectionSyncing => 'Sincronizando…';
  @override
  String get connectionDisconnected => 'No conectado';
  @override
  String get connectionAttention => 'Necesita atención';
  @override
  String get connectionConnect => 'Conectar';
  @override
  String get connectionDisconnect => 'Desconectar';
  @override
  String get connectionReindex => 'Reindexar';
  @override
  String lastSynced(String ago) => 'Sincronizado $ago';

  @override
  String get privacyTitle => 'Centro de privacidad';
  @override
  String get privacyLocalActive => 'Procesamiento local activo';
  @override
  String get privacyCloudOff => 'Inteligencia en la nube desactivada';
  @override
  String get privacyCloudOn => 'Inteligencia en la nube activada';
  @override
  String get privacyOnDevice => 'Permanece en este dispositivo';
  @override
  String get privacyOnDeviceBody =>
      'Tu índice, tus vistas previas y tu historial de búsqueda se guardan '
      'en tu dispositivo.';
  @override
  String get privacyCloudSection => 'Enviado a la nube';
  @override
  String get privacyCloudBody =>
      'Nada, a menos que actives Inteligencia en la nube para obtener '
      'respuestas más completas.';
  @override
  String get privacyLocalAi => 'IA en el dispositivo';
  @override
  String get privacyCloudAi => 'Inteligencia en la nube';
  @override
  String get privacyAppLock => 'Bloqueo de la app';
  @override
  String get privacyBiometric => 'Face ID / Touch ID';
  @override
  String get privacySensitive => 'Protección de contenido sensible';
  @override
  String get privacyExport => 'Exportar mis datos';
  @override
  String get privacyClearHistory => 'Borrar historial de búsqueda';
  @override
  String get privacyDeleteAll => 'Eliminar todos los datos';
  @override
  String get privacyDeleteConfirmTitle => '¿Eliminar todo?';
  @override
  String get privacyDeleteConfirmBody =>
      'Esto elimina todo tu índice de memoria de este dispositivo. Los '
      'originales en tus apps no se ven afectados.';
  @override
  String get cancel => 'Cancelar';
  @override
  String get confirmDelete => 'Eliminar';

  @override
  String get settingsTitle => 'Perfil';
  @override
  String get settingsTheme => 'Tema';
  @override
  String get settingsThemeDark => 'Oscuro';
  @override
  String get settingsThemeLight => 'Claro';
  @override
  String get settingsThemeSystem => 'Sistema';
  @override
  String get settingsLanguage => 'Idioma';
  @override
  String get settingsSearchSources => 'Fuentes de búsqueda predeterminadas';
  @override
  String get settingsVoice => 'Búsqueda por voz';
  @override
  String get settingsStorage => 'Almacenamiento';
  @override
  String get settingsIndexing => 'Indexación';
  @override
  String get settingsNotifications => 'Notificaciones';
  @override
  String get settingsConnectedAccounts => 'Cuentas conectadas';
  @override
  String get settingsPrivacySecurity => 'Privacidad y seguridad';
  @override
  String get settingsSubscription => 'Suscripción';
  @override
  String get settingsPremium => 'JARA Premium';
  @override
  String get settingsPremiumBody =>
      'Inteligencia en la nube, conexiones ilimitadas e indexación '
      'prioritaria.';

  @override
  String get paywallTitle => 'Más alcance, cuando lo necesites';
  @override
  String get paywallSubtitle =>
      'Premium añade tres cosas a JARA. La búsqueda se queda tal como está.';
  @override
  String get paywallFeatCloudTitle => 'Inteligencia en la nube';
  @override
  String get paywallFeatCloudBody =>
      'Respuestas más completas cuando eliges la nube. Permanece desactivada '
      'hasta que tú la actives, y la decisión siempre es tuya.';
  @override
  String get paywallFeatConnectionsTitle => 'Conexiones ilimitadas';
  @override
  String get paywallFeatConnectionsBody =>
      'El plan gratuito mantiene conectado un número limitado de fuentes. '
      'Premium conecta todas las cuentas que uses.';
  @override
  String get paywallFeatIndexingTitle => 'Indexación prioritaria';
  @override
  String get paywallFeatIndexingBody =>
      'Lo que guardas se puede buscar antes, incluso mientras se completa '
      'una importación grande.';
  @override
  String get paywallMonthly => 'Mensual';
  @override
  String get paywallYearly => 'Anual';
  @override
  String get paywallYearlyBadge => 'Mejor opción';
  @override
  String get paywallPriceNote =>
      'El precio aparece al pagar, en la moneda de tu región.';
  @override
  String get paywallCta => 'Empezar con Premium';
  @override
  String get paywallRestore => 'Restaurar compras';
  @override
  String get paywallTerms => 'Términos';
  @override
  String get paywallSearchFree =>
      'Buscar en tu propia memoria es gratis, siempre. Premium nunca bloquea '
      'lo que ya tienes.';
  @override
  String get paywallNotWiredNote =>
      'Las compras llegan con la versión de la tienda.';

  @override
  String get back => 'Atrás';
  @override
  String get moreActions => 'Más acciones';
  @override
  String get done => 'Listo';
  @override
  String get apply => 'Aplicar';
  @override
  String get continueCta => 'Continuar';
  @override
  String get searchAction => 'Buscar';
  @override
  String get sortBy => 'Ordenar por';
  @override
  String get listening => 'Escuchando…';
  @override
  String get alwaysOn => 'Siempre activo';
  @override
  String get clearDateFilter => 'Borrar filtro de fecha';
  @override
  String get sectionGeneral => 'General';
  @override
  String get sectionIntelligence => 'Inteligencia';
  @override
  String get sectionData => 'Datos';
  @override
  String get productName => 'Universal Search';
  @override
  String get manualAddSource => 'Añadido por ti';
  @override
  String get addedJustNow =>
      'Añadido justo ahora — JARA lo está haciendo buscable.';

  @override
  String errorTitle(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'JARA necesita tu permiso',
        JaraError.fileUnreadable => 'Este archivo no se abre',
        JaraError.indexingFailed => 'La indexación se detuvo antes de tiempo',
        JaraError.accountDisconnected => 'La cuenta necesita reconectarse',
        JaraError.noConnection => 'Estás sin conexión',
        JaraError.localModelNotReady => 'Todavía se está preparando',
        JaraError.storageFull => 'No queda espacio en este dispositivo',
        JaraError.sourceMissing => 'El original ya no está',
        JaraError.generic => 'Algo necesita reintentarse',
      };

  @override
  String errorBody(JaraError e) => switch (e) {
        JaraError.permissionDenied =>
          'Permite el acceso a esta fuente y podrás buscarla de inmediato.',
        JaraError.fileUnreadable =>
          'El archivo podría estar dañado o en un formato que JARA aún no '
              'puede leer.',
        JaraError.indexingFailed =>
          'Algunos elementos no se añadieron. Tu memoria actual no se ha '
              'visto afectada.',
        JaraError.accountDisconnected =>
          'Vuelve a iniciar sesión para mantener actualizados los '
              'elementos de esta cuenta.',
        JaraError.noConnection =>
          'Tu memoria en el dispositivo sigue funcionando. Las funciones '
              'en la nube se reanudarán automáticamente.',
        JaraError.localModelNotReady =>
          'La búsqueda en el dispositivo está terminando de configurarse. '
              'Esto tarda un momento la primera vez.',
        JaraError.storageFull =>
          'Libera algo de espacio para que JARA pueda terminar de indexar.',
        JaraError.sourceMissing =>
          'Este elemento se movió o se eliminó en su app original.',
        JaraError.generic =>
          'Eso no se pudo completar. Tu memoria está a salvo — inténtalo '
              'de nuevo.',
      };

  @override
  String? errorCta(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'Abrir ajustes',
        JaraError.fileUnreadable => null,
        JaraError.indexingFailed => 'Reintentar',
        JaraError.accountDisconnected => 'Reconectar',
        JaraError.noConnection => null,
        JaraError.localModelNotReady => null,
        JaraError.storageFull => 'Gestionar almacenamiento',
        JaraError.sourceMissing => 'Quitar de la memoria',
        JaraError.generic => 'Reintentar',
      };

  @override
  String get needsConnection => 'Requiere conexión';

  @override
  String get emptyResultsTitle => 'Todavía no hay coincidencias';
  @override
  String get emptyResultsBody =>
      'Prueba a cambiar la fecha, la fuente o las palabras.';
  @override
  String get emptyResultsAdjust => 'Ajustar filtros';
  @override
  String get emptyResultsSearchAll => 'Buscar en toda la memoria';
  @override
  String get emptyMemoryTitle => 'Tu memoria empieza aquí';
  @override
  String get emptyMemoryBody =>
      'Añade un archivo, una captura de pantalla, un enlace o una nota. '
      'JARA lo hará buscable.';
  @override
  String get emptyMemoryCta => 'Añadir primer recuerdo';
  @override
  String get offlineLabel => 'La búsqueda sin conexión está activa';
  @override
  String get offlineBody =>
      'Tu memoria en el dispositivo sigue funcionando. Las funciones en '
      'la nube se reanudarán automáticamente.';
  @override
  String get errorGenericTitle => 'Algo necesita reintentarse';
  @override
  String get errorGenericBody =>
      'Eso no se pudo completar. Tu memoria está a salvo — inténtalo de '
      'nuevo.';
  @override
  String get retry => 'Reintentar';

  @override
  String get shareTitle => 'Guardar en JARA';
  @override
  String get shareSaveInstantly => 'Guardar al instante';
  @override
  String get shareReview => 'Revisar detalles';
  @override
  String get shareSaved => 'Guardado en tu memoria';

  @override
  String get today => 'Hoy';
  @override
  String get tomorrow => 'Mañana';
  @override
  String get yesterday => 'Ayer';
  @override
  String daysAgo(int days) =>
      days == 1 ? 'hace 1 día' : 'hace $days días';
  @override
  String inDays(int days) => days == 1 ? 'en 1 día' : 'en $days días';
  @override
  String minutesAgo(int m) =>
      m == 1 ? 'hace 1 minuto' : 'hace $m minutos';
  @override
  String hoursAgo(int h) => h == 1 ? 'hace 1 hora' : 'hace $h horas';
}
