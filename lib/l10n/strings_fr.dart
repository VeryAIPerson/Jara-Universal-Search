import '../core/models/memory_item.dart';
import 'strings.dart';

class JaraStringsFr extends JaraStrings {
  const JaraStringsFr();

  @override
  String get appName => 'JARA Universal Search';
  @override
  String get tagline => 'Tout ce qui compte. Une seule recherche.';

  @override
  String get onb1Title => 'Tout ce qui compte.\nUne seule recherche.';
  @override
  String get onb1Body =>
      'Retrouvez vos fichiers, photos, notes et liens dans une seule '
      'mémoire personnelle.';
  @override
  String get onb2Title => 'Privé par conception';
  @override
  String get onb2Body =>
      'Votre contenu est traité sur votre appareil dans la mesure du '
      'possible — vous gardez toujours le contrôle.';
  @override
  String get onb3Title => 'Enregistrez une fois.\nRetrouvez à tout moment.';
  @override
  String get onb3Body =>
      'Partagez depuis n’importe quelle app vers JARA, puis retrouvez-le '
      'plus tard avec vos propres mots.';
  @override
  String get onbPrimaryCta => 'Créer ma mémoire';
  @override
  String get onbSecondaryCta => 'Découvrir la démo';
  @override
  String get onbSkip => 'Passer';

  @override
  String greetingMorning(String name) =>
      name.isEmpty ? 'Bonjour' : 'Bonjour, $name';
  @override
  String greetingDay(String name) =>
      name.isEmpty ? 'Bon après-midi' : 'Bon après-midi, $name';
  @override
  String greetingEvening(String name) =>
      name.isEmpty ? 'Bonsoir' : 'Bonsoir, $name';
  @override
  String get searchTitle => 'Retrouvez tout\nce que vous avez enregistré.';
  @override
  List<String> get searchHints => const [
        'Trouvez le document sur mon voyage à Londres',
        'Montrez les captures d’écran avec des détails de paiement',
        'Qu’ai-je enregistré sur les tarifs de VoxBridge ?',
        'Trouvez mon rendez-vous chez le médecin',
        'Montrez les photos avec un passeport',
      ];
  @override
  String get filterAll => 'Tout';

  @override
  String typeLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Document',
        MemoryType.photo => 'Photo',
        MemoryType.screenshot => 'Capture d’écran',
        MemoryType.note => 'Note',
        MemoryType.link => 'Lien',
        MemoryType.audio => 'Audio',
        MemoryType.calendar => 'Calendrier',
        MemoryType.email => 'E-mail',
        MemoryType.chat => 'Chat',
      };

  @override
  String typePluralLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Documents',
        MemoryType.photo => 'Photos',
        MemoryType.screenshot => 'Captures d’écran',
        MemoryType.note => 'Notes',
        MemoryType.link => 'Liens',
        MemoryType.audio => 'Audio',
        MemoryType.calendar => 'Calendrier',
        MemoryType.email => 'E-mails',
        MemoryType.chat => 'Chats',
      };

  @override
  String get sourcesSection => 'Votre mémoire';
  @override
  String get recentSearches => 'Recherches récentes';
  @override
  String get recentlySaved => 'Enregistré récemment';
  @override
  String get suggestedSearches => 'Essayez de demander';
  @override
  String get seeAll => 'Tout voir';
  @override
  String get memoryStatusTitle => 'Ma mémoire';
  @override
  String memoryStatusItems(int items, int collections) =>
      '${items == 1 ? '1 élément' : '$items éléments'} · '
      '${collections == 1 ? '1 collection' : '$collections collections'}';
  @override
  String memoryStatusFree(String free) => free;
  @override
  String indexedAgo(String ago) => 'Indexé $ago';
  @override
  String newItemsThisWeek(int count) => count == 1
      ? '+1 nouveau cette semaine'
      : '+$count nouveaux cette semaine';

  @override
  String get suggestionsHistory => 'Récentes';
  @override
  String get suggestionsSmart => 'Suggestions';

  @override
  String resultsCount(int count, String elapsed) =>
      '${count == 1 ? '1 résultat' : '$count résultats'} · $elapsed';
  @override
  String get bestMatch => 'Meilleure correspondance';
  @override
  String get smartSummaryTitle => 'Résumé intelligent';
  @override
  String basedOnItems(int count) => count == 1
      ? 'Basé sur 1 élément enregistré'
      : 'Basé sur $count éléments enregistrés';
  @override
  String get viewSources => 'Voir les sources';
  @override
  String get refineSearch => 'Affiner la recherche';
  @override
  String get saveAnswer => 'Enregistrer la réponse';
  @override
  String get copied => 'Copié';
  @override
  String get sortRecent => 'Plus récent';
  @override
  String get sortRelevance => 'Meilleure correspondance';

  @override
  String get actionOpen => 'Ouvrir';
  @override
  String get actionPreview => 'Aperçu';
  @override
  String get actionShare => 'Partager';
  @override
  String get actionPin => 'Épingler';
  @override
  String get actionUnpin => 'Désépingler';
  @override
  String get actionAddTag => 'Ajouter une étiquette';
  @override
  String get actionSaveToCollection => 'Enregistrer dans une collection';
  @override
  String get actionAskAbout => 'Poser une question à ce sujet';
  @override
  String get actionDelete => 'Supprimer de la mémoire';
  @override
  String get actionOpenOriginal => 'Ouvrir l’original';
  @override
  String get actionAskJara => 'Demander à JARA';

  @override
  String get detailRelated => 'Souvenirs associés';
  @override
  String get detailInCollection => 'Collection';
  @override
  String get detailTags => 'Étiquettes';
  @override
  String get detailPeople => 'Personnes';
  @override
  String get detailSource => 'Source';
  @override
  String get detailAskPlaceholder => 'Posez une question sur ce souvenir…';

  @override
  String get addTitle => 'Ajouter à JARA';
  @override
  String get addScanDocument => 'Numériser un document';
  @override
  String get addUploadFile => 'Importer un fichier';
  @override
  String get addPhoto => 'Ajouter une photo';
  @override
  String get addScreenshot => 'Ajouter une capture d’écran';
  @override
  String get addVoiceNote => 'Enregistrer une note vocale';
  @override
  String get addPasteText => 'Coller du texte';
  @override
  String get addSaveLink => 'Enregistrer un lien';
  @override
  String get addCreateNote => 'Créer une note';
  @override
  String get addConnectAccount => 'Connecter un compte';
  @override
  String get addImportCalendar => 'Importer un calendrier';
  @override
  String get addSuccessTitle => 'Enregistré dans votre mémoire';
  @override
  String get addSuccessSearchNow => 'Rechercher maintenant';
  @override
  String get addSuggestedTitle => 'Titre suggéré';
  @override
  String get addSuggestedTags => 'Étiquettes suggérées';
  @override
  String get addCollection => 'Collection';
  @override
  String get addSaveInstantly => 'Enregistrer instantanément';
  @override
  String get addSave => 'Enregistrer';

  @override
  String get memoryTitle => 'Mémoire';
  @override
  String get memoryAll => 'Tous les souvenirs';
  @override
  String get memoryPinned => 'Épinglés';
  @override
  String get memoryRecent => 'Récents';
  @override
  String get memoryTimeline => 'Chronologie';
  @override
  String get collectionsTitle => 'Collections';
  @override
  String collectionItems(int count) =>
      count == 1 ? '1 élément' : '$count éléments';
  @override
  String updatedAgo(String ago) => 'Mis à jour $ago';

  @override
  String get connectionsTitle => 'Connexions';
  @override
  String get connectionsSubtitle =>
      'Choisissez ce que JARA peut indexer. Vous pouvez vous déconnecter '
      'à tout moment.';
  @override
  String get connectionConnected => 'Connecté';
  @override
  String get connectionSyncing => 'Synchronisation…';
  @override
  String get connectionDisconnected => 'Non connecté';
  @override
  String get connectionAttention => 'Nécessite votre attention';
  @override
  String get connectionConnect => 'Connecter';
  @override
  String get connectionDisconnect => 'Déconnecter';
  @override
  String get connectionReindex => 'Réindexer';
  @override
  String lastSynced(String ago) => 'Synchronisé $ago';

  @override
  String get privacyTitle => 'Centre de confidentialité';
  @override
  String get privacyLocalActive => 'Traitement local actif';
  @override
  String get privacyCloudOff => 'Intelligence cloud désactivée';
  @override
  String get privacyCloudOn => 'Intelligence cloud activée';
  @override
  String get privacyOnDevice => 'Reste sur cet appareil';
  @override
  String get privacyOnDeviceBody =>
      'Votre index, vos aperçus et votre historique de recherche sont '
      'stockés sur votre appareil.';
  @override
  String get privacyCloudSection => 'Envoyé au cloud';
  @override
  String get privacyCloudBody =>
      'Rien, sauf si vous activez l’Intelligence cloud pour des réponses '
      'plus complètes.';
  @override
  String get privacyLocalAi => 'IA sur l’appareil';
  @override
  String get privacyCloudAi => 'Intelligence cloud';
  @override
  String get privacyAppLock => 'Verrouillage de l’app';
  @override
  String get privacyBiometric => 'Face ID / Touch ID';
  @override
  String get privacySensitive => 'Protection du contenu sensible';
  @override
  String get privacyExport => 'Exporter mes données';
  @override
  String get privacyClearHistory => 'Effacer l’historique de recherche';
  @override
  String get privacyDeleteAll => 'Supprimer toutes les données';
  @override
  String get privacyDeleteConfirmTitle => 'Tout supprimer ?';
  @override
  String get privacyDeleteConfirmBody =>
      'Cela supprime tout votre index de mémoire de cet appareil. Les '
      'originaux dans vos applications ne sont pas concernés.';
  @override
  String get cancel => 'Annuler';
  @override
  String get confirmDelete => 'Supprimer';

  @override
  String get settingsTitle => 'Profil';
  @override
  String get settingsTheme => 'Thème';
  @override
  String get settingsThemeDark => 'Sombre';
  @override
  String get settingsThemeLight => 'Clair';
  @override
  String get settingsThemeSystem => 'Système';
  @override
  String get settingsLanguage => 'Langue';
  @override
  String get settingsSearchSources => 'Sources de recherche par défaut';
  @override
  String get settingsVoice => 'Recherche vocale';
  @override
  String get settingsStorage => 'Stockage';
  @override
  String get settingsIndexing => 'Indexation';
  @override
  String get settingsNotifications => 'Notifications';
  @override
  String get settingsConnectedAccounts => 'Comptes connectés';
  @override
  String get settingsPrivacySecurity => 'Confidentialité et sécurité';
  @override
  String get settingsSubscription => 'Abonnement';
  @override
  String get settingsPremium => 'JARA Premium';
  @override
  String get settingsPremiumBody =>
      'Intelligence cloud, connexions illimitées et indexation '
      'prioritaire.';

  @override
  String get paywallTitle => 'Plus de portée, quand vous en avez besoin';
  @override
  String get paywallSubtitle =>
      'Premium ajoute trois choses à JARA. La recherche, elle, ne change '
      'pas.';
  @override
  String get paywallFeatCloudTitle => 'Intelligence cloud';
  @override
  String get paywallFeatCloudBody =>
      'Des réponses plus riches quand vous choisissez le cloud. Elle reste '
      'désactivée jusqu’à ce que vous l’activiez, et le choix vous '
      'appartient.';
  @override
  String get paywallFeatConnectionsTitle => 'Connexions illimitées';
  @override
  String get paywallFeatConnectionsBody =>
      'La formule gratuite garde un nombre limité de sources connectées. '
      'Premium connecte chaque compte que vous utilisez.';
  @override
  String get paywallFeatIndexingTitle => 'Indexation prioritaire';
  @override
  String get paywallFeatIndexingBody =>
      'Vos nouveaux enregistrements deviennent consultables en premier, même '
      'pendant un import volumineux.';
  @override
  String get paywallMonthly => 'Mensuel';
  @override
  String get paywallYearly => 'Annuel';
  @override
  String get paywallYearlyBadge => 'Meilleure offre';
  @override
  String get paywallPriceNote =>
      'Le prix s’affiche au moment du paiement, dans la devise de votre '
      'région.';
  @override
  String get paywallCta => 'Commencer avec Premium';
  @override
  String get paywallRestore => 'Restaurer les achats';
  @override
  String get paywallTerms => 'Conditions';
  @override
  String get paywallSearchFree =>
      'La recherche dans votre propre mémoire est gratuite, toujours. '
      'Premium ne verrouille jamais ce que vous avez déjà.';
  @override
  String get paywallNotWiredNote =>
      'Les achats arriveront avec la version publiée sur les stores.';

  @override
  String get back => 'Retour';
  @override
  String get moreActions => 'Plus d’actions';
  @override
  String get done => 'Terminé';
  @override
  String get apply => 'Appliquer';
  @override
  String get continueCta => 'Continuer';
  @override
  String get searchAction => 'Rechercher';
  @override
  String get sortBy => 'Trier par';
  @override
  String get listening => 'Écoute…';
  @override
  String get alwaysOn => 'Toujours actif';
  @override
  String get clearDateFilter => 'Effacer le filtre de date';
  @override
  String get sectionGeneral => 'Général';
  @override
  String get sectionIntelligence => 'Intelligence';
  @override
  String get sectionData => 'Données';
  @override
  String get productName => 'Universal Search';
  @override
  String get manualAddSource => 'Ajouté par vous';
  @override
  String get addedJustNow =>
      'Ajouté à l’instant — JARA le rend facile à retrouver.';

  @override
  String errorTitle(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'JARA a besoin de votre accord',
        JaraError.fileUnreadable => 'Ce fichier ne s’ouvre pas',
        JaraError.indexingFailed => 'L’indexation s’est arrêtée en cours',
        JaraError.accountDisconnected => 'Le compte doit être reconnecté',
        JaraError.noConnection => 'Vous êtes hors ligne',
        JaraError.localModelNotReady => 'Préparation en cours',
        JaraError.storageFull => 'Il n’y a plus de place sur cet appareil',
        JaraError.sourceMissing => 'L’original a disparu',
        JaraError.generic => 'Une nouvelle tentative est nécessaire',
      };

  @override
  String errorBody(JaraError e) => switch (e) {
        JaraError.permissionDenied =>
          'Autorisez l’accès à cette source pour qu’elle devienne '
              'consultable immédiatement.',
        JaraError.fileUnreadable =>
          'Le fichier est peut-être endommagé ou dans un format que JARA '
              'ne sait pas encore lire.',
        JaraError.indexingFailed =>
          'Certains éléments n’ont pas été ajoutés. Votre mémoire '
              'existante n’a pas été modifiée.',
        JaraError.accountDisconnected =>
          'Reconnectez-vous pour que les éléments de ce compte restent '
              'à jour.',
        JaraError.noConnection =>
          'Votre mémoire sur l’appareil continue de fonctionner. Les '
              'fonctionnalités cloud reprendront automatiquement.',
        JaraError.localModelNotReady =>
          'La recherche sur l’appareil termine sa configuration. Cela '
              'prend un instant lors du premier lancement.',
        JaraError.storageFull =>
          'Libérez de l’espace pour que JARA puisse terminer '
              'l’indexation.',
        JaraError.sourceMissing =>
          'Cet élément a été déplacé ou supprimé dans son application '
              'd’origine.',
        JaraError.generic =>
          'Cela n’est pas passé. Votre mémoire est en sécurité — '
              'réessayez.',
      };

  @override
  String? errorCta(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'Ouvrir les réglages',
        JaraError.fileUnreadable => null,
        JaraError.indexingFailed => 'Réessayer',
        JaraError.accountDisconnected => 'Reconnecter',
        JaraError.noConnection => null,
        JaraError.localModelNotReady => null,
        JaraError.storageFull => 'Gérer le stockage',
        JaraError.sourceMissing => 'Retirer de la mémoire',
        JaraError.generic => 'Réessayer',
      };

  @override
  String get needsConnection => 'Connexion requise';

  @override
  String get emptyResultsTitle => 'Encore aucun résultat';
  @override
  String get emptyResultsBody =>
      'Essayez de changer la date, la source ou les termes utilisés.';
  @override
  String get emptyResultsAdjust => 'Ajuster les filtres';
  @override
  String get emptyResultsSearchAll => 'Rechercher dans toute la mémoire';
  @override
  String get emptyMemoryTitle => 'Votre mémoire commence ici';
  @override
  String get emptyMemoryBody =>
      'Ajoutez un fichier, une capture d’écran, un lien ou une note. '
      'JARA le rendra facile à retrouver.';
  @override
  String get emptyMemoryCta => 'Ajouter votre premier souvenir';
  @override
  String get offlineLabel => 'La recherche hors ligne est active';
  @override
  String get offlineBody =>
      'Votre mémoire sur l’appareil continue de fonctionner. Les '
      'fonctionnalités cloud reprendront automatiquement.';
  @override
  String get errorGenericTitle => 'Une nouvelle tentative est nécessaire';
  @override
  String get errorGenericBody =>
      'Cela n’est pas passé. Votre mémoire est en sécurité — réessayez.';
  @override
  String get retry => 'Réessayer';

  @override
  String get shareTitle => 'Enregistrer dans JARA';
  @override
  String get shareSaveInstantly => 'Enregistrer instantanément';
  @override
  String get shareReview => 'Vérifier les détails';
  @override
  String get shareSaved => 'Enregistré dans votre mémoire';

  @override
  String get today => 'Aujourd’hui';
  @override
  String get tomorrow => 'Demain';
  @override
  String get yesterday => 'Hier';
  @override
  String daysAgo(int days) =>
      days == 1 ? 'il y a 1 jour' : 'il y a $days jours';
  @override
  String inDays(int days) =>
      days == 1 ? 'dans 1 jour' : 'dans $days jours';
  @override
  String minutesAgo(int m) =>
      m == 1 ? 'il y a 1 minute' : 'il y a $m minutes';
  @override
  String hoursAgo(int h) =>
      h == 1 ? 'il y a 1 heure' : 'il y a $h heures';
}
