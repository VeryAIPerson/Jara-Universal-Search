import '../core/models/memory_item.dart';
import 'strings.dart';

class JaraStringsPtBr extends JaraStrings {
  const JaraStringsPtBr();

  @override
  String get appName => 'JARA Universal Search';
  @override
  String get tagline => 'Tudo o que importa. Uma única busca.';

  @override
  String get onb1Title => 'Tudo o que importa.\nUma única busca.';
  @override
  String get onb1Body =>
      'Encontre seus arquivos, fotos, notas e links em uma única memória '
      'pessoal.';
  @override
  String get onb2Title => 'Privado por design';
  @override
  String get onb2Body =>
      'Seu conteúdo é processado no seu dispositivo sempre que possível '
      '— o controle é sempre seu.';
  @override
  String get onb3Title => 'Salve uma vez.\nEncontre quando quiser.';
  @override
  String get onb3Body =>
      'Compartilhe de qualquer aplicativo para o JARA e encontre depois, '
      'com suas próprias palavras.';
  @override
  String get onbPrimaryCta => 'Criar minha memória';
  @override
  String get onbSecondaryCta => 'Explorar demo';
  @override
  String get onbSkip => 'Pular';

  @override
  String greetingMorning(String name) =>
      name.isEmpty ? 'Bom dia' : 'Bom dia, $name';
  @override
  String greetingDay(String name) =>
      name.isEmpty ? 'Boa tarde' : 'Boa tarde, $name';
  @override
  String greetingEvening(String name) =>
      name.isEmpty ? 'Boa noite' : 'Boa noite, $name';
  @override
  String get searchTitle => 'Encontre tudo\no que você salvou.';
  @override
  List<String> get searchHints => const [
        'Encontre o documento da minha viagem a Londres',
        'Mostre capturas de tela com dados de pagamento',
        'O que eu salvei sobre os preços do VoxBridge?',
        'Encontre minha consulta médica',
        'Mostre fotos com um passaporte',
      ];
  @override
  String get filterAll => 'Tudo';

  @override
  String typeLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Documento',
        MemoryType.photo => 'Foto',
        MemoryType.screenshot => 'Captura de tela',
        MemoryType.note => 'Nota',
        MemoryType.link => 'Link',
        MemoryType.audio => 'Áudio',
        MemoryType.calendar => 'Calendário',
        MemoryType.email => 'E-mail',
        MemoryType.chat => 'Chat',
      };

  @override
  String typePluralLabel(MemoryType type) => switch (type) {
        MemoryType.document => 'Documentos',
        MemoryType.photo => 'Fotos',
        MemoryType.screenshot => 'Capturas de tela',
        MemoryType.note => 'Notas',
        MemoryType.link => 'Links',
        MemoryType.audio => 'Áudio',
        MemoryType.calendar => 'Calendário',
        MemoryType.email => 'E-mails',
        MemoryType.chat => 'Chats',
      };

  @override
  String get sourcesSection => 'Sua memória';
  @override
  String get recentSearches => 'Buscas recentes';
  @override
  String get recentlySaved => 'Salvo recentemente';
  @override
  String get suggestedSearches => 'Experimente perguntar';
  @override
  String get seeAll => 'Ver tudo';
  @override
  String get memoryStatusTitle => 'Minha memória';
  @override
  String memoryStatusItems(int items, int collections) =>
      '${items == 1 ? '1 item' : '$items itens'} · '
      '${collections == 1 ? '1 coleção' : '$collections coleções'}';
  @override
  String memoryStatusFree(String free) => free;
  @override
  String indexedAgo(String ago) => 'Indexado $ago';
  @override
  String newItemsThisWeek(int count) =>
      count == 1 ? '+1 novo esta semana' : '+$count novos esta semana';

  @override
  String get suggestionsHistory => 'Recentes';
  @override
  String get suggestionsSmart => 'Sugestões';

  @override
  String resultsCount(int count, String elapsed) =>
      '${count == 1 ? '1 resultado' : '$count resultados'} · $elapsed';
  @override
  String get bestMatch => 'Melhor correspondência';
  @override
  String get smartSummaryTitle => 'Resumo inteligente';
  @override
  String basedOnItems(int count) => count == 1
      ? 'Baseado em 1 item salvo'
      : 'Baseado em $count itens salvos';
  @override
  String get viewSources => 'Ver fontes';
  @override
  String get refineSearch => 'Refinar busca';
  @override
  String get saveAnswer => 'Salvar resposta';
  @override
  String get copied => 'Copiado';
  @override
  String get sortRecent => 'Mais recente';
  @override
  String get sortRelevance => 'Melhor correspondência';

  @override
  String get actionOpen => 'Abrir';
  @override
  String get actionPreview => 'Pré-visualizar';
  @override
  String get actionShare => 'Compartilhar';
  @override
  String get actionPin => 'Fixar';
  @override
  String get actionUnpin => 'Desafixar';
  @override
  String get actionAddTag => 'Adicionar etiqueta';
  @override
  String get actionSaveToCollection => 'Salvar em coleção';
  @override
  String get actionAskAbout => 'Perguntar sobre isto';
  @override
  String get actionDelete => 'Excluir da memória';
  @override
  String get actionOpenOriginal => 'Abrir original';
  @override
  String get actionAskJara => 'Perguntar ao JARA';

  @override
  String get detailRelated => 'Lembranças relacionadas';
  @override
  String get detailInCollection => 'Coleção';
  @override
  String get detailTags => 'Etiquetas';
  @override
  String get detailPeople => 'Pessoas';
  @override
  String get detailSource => 'Fonte';
  @override
  String get detailAskPlaceholder => 'Pergunte sobre esta lembrança…';

  @override
  String get addTitle => 'Adicionar ao JARA';
  @override
  String get addScanDocument => 'Escanear documento';
  @override
  String get addUploadFile => 'Enviar arquivo';
  @override
  String get addPhoto => 'Adicionar foto';
  @override
  String get addScreenshot => 'Adicionar captura de tela';
  @override
  String get addVoiceNote => 'Gravar nota de voz';
  @override
  String get addPasteText => 'Colar texto';
  @override
  String get addSaveLink => 'Salvar link';
  @override
  String get addCreateNote => 'Criar nota';
  @override
  String get addConnectAccount => 'Conectar conta';
  @override
  String get addImportCalendar => 'Importar calendário';
  @override
  String get addSuccessTitle => 'Salvo na sua memória';
  @override
  String get addSuccessSearchNow => 'Buscar agora';
  @override
  String get addSuggestedTitle => 'Título sugerido';
  @override
  String get addSuggestedTags => 'Etiquetas sugeridas';
  @override
  String get addCollection => 'Coleção';
  @override
  String get addSaveInstantly => 'Salvar instantaneamente';
  @override
  String get addSave => 'Salvar';

  @override
  String get memoryTitle => 'Memória';
  @override
  String get memoryAll => 'Todas as lembranças';
  @override
  String get memoryPinned => 'Fixados';
  @override
  String get memoryRecent => 'Recentes';
  @override
  String get memoryTimeline => 'Linha do tempo';
  @override
  String get collectionsTitle => 'Coleções';
  @override
  String collectionItems(int count) =>
      count == 1 ? '1 item' : '$count itens';
  @override
  String updatedAgo(String ago) => 'Atualizado $ago';

  @override
  String get connectionsTitle => 'Conexões';
  @override
  String get connectionsSubtitle =>
      'Escolha o que o JARA pode indexar. Você pode desconectar quando '
      'quiser.';
  @override
  String get connectionConnected => 'Conectado';
  @override
  String get connectionSyncing => 'Sincronizando…';
  @override
  String get connectionDisconnected => 'Não conectado';
  @override
  String get connectionAttention => 'Precisa de atenção';
  @override
  String get connectionConnect => 'Conectar';
  @override
  String get connectionDisconnect => 'Desconectar';
  @override
  String get connectionReindex => 'Reindexar';
  @override
  String lastSynced(String ago) => 'Sincronizado $ago';

  @override
  String get privacyTitle => 'Central de privacidade';
  @override
  String get privacyLocalActive => 'Processamento local ativo';
  @override
  String get privacyCloudOff => 'Inteligência na nuvem desativada';
  @override
  String get privacyCloudOn => 'Inteligência na nuvem ativada';
  @override
  String get privacyOnDevice => 'Permanece neste dispositivo';
  @override
  String get privacyOnDeviceBody =>
      'Seu índice, suas prévias e seu histórico de busca ficam '
      'armazenados no seu dispositivo.';
  @override
  String get privacyCloudSection => 'Enviado à nuvem';
  @override
  String get privacyCloudBody =>
      'Nada, a menos que você ative a Inteligência na nuvem para '
      'respostas mais completas.';
  @override
  String get privacyLocalAi => 'IA no dispositivo';
  @override
  String get privacyCloudAi => 'Inteligência na nuvem';
  @override
  String get privacyAppLock => 'Bloqueio do app';
  @override
  String get privacyBiometric => 'Face ID / Touch ID';
  @override
  String get privacySensitive => 'Proteção de conteúdo sensível';
  @override
  String get privacyExport => 'Exportar meus dados';
  @override
  String get privacyClearHistory => 'Limpar histórico de busca';
  @override
  String get privacyDeleteAll => 'Excluir todos os dados';
  @override
  String get privacyDeleteConfirmTitle => 'Excluir tudo?';
  @override
  String get privacyDeleteConfirmBody =>
      'Isso remove todo o seu índice de memória deste dispositivo. Os '
      'originais nos seus aplicativos não são afetados.';
  @override
  String get privacyDeleted =>
      'Memória excluída deste dispositivo.';
  @override
  String get cancel => 'Cancelar';
  @override
  String get confirmDelete => 'Excluir';

  @override
  String get settingsTitle => 'Perfil';
  @override
  String get settingsTheme => 'Tema';
  @override
  String get settingsThemeDark => 'Escuro';
  @override
  String get settingsThemeLight => 'Claro';
  @override
  String get settingsThemeSystem => 'Sistema';
  @override
  String get settingsLanguage => 'Idioma';
  @override
  String get settingsSearchSources => 'Fontes de busca padrão';
  @override
  String get settingsVoice => 'Busca por voz';
  @override
  String get settingsStorage => 'Armazenamento';
  @override
  String get settingsIndexing => 'Indexação';
  @override
  String get settingsNotifications => 'Notificações';
  @override
  String get settingsConnectedAccounts => 'Contas conectadas';
  @override
  String get settingsPrivacySecurity => 'Privacidade e segurança';
  @override
  String get settingsSubscription => 'Assinatura';
  @override
  String get settingsPremium => 'JARA Premium';
  @override
  String get settingsPremiumBody =>
      'Inteligência na nuvem, conexões ilimitadas e indexação '
      'prioritária.';

  @override
  String get paywallTitle => 'Mais alcance, quando você precisar';
  @override
  String get paywallSubtitle =>
      'O Premium adiciona três coisas ao JARA. A busca continua exatamente '
      'como é.';
  @override
  String get paywallFeatCloudTitle => 'Inteligência na nuvem';
  @override
  String get paywallFeatCloudBody =>
      'Respostas mais completas quando você escolhe a nuvem. Fica desligada '
      'até você ativar, e a decisão é sempre sua.';
  @override
  String get paywallFeatConnectionsTitle => 'Conexões ilimitadas';
  @override
  String get paywallFeatConnectionsBody =>
      'O plano gratuito mantém um número limitado de fontes conectadas. Com '
      'o Premium, conecte todas as contas que você usa.';
  @override
  String get paywallFeatIndexingTitle => 'Indexação prioritária';
  @override
  String get paywallFeatIndexingBody =>
      'O que você salva fica pesquisável primeiro, mesmo com uma importação '
      'grande em andamento.';
  @override
  String get paywallMonthly => 'Mensal';
  @override
  String get paywallYearly => 'Anual';
  @override
  String get paywallYearlyBadge => 'Melhor escolha';
  @override
  String get paywallPriceNote =>
      'O preço aparece no pagamento, na moeda da sua região.';
  @override
  String get paywallCta => 'Começar com o Premium';
  @override
  String get paywallRestore => 'Restaurar compras';
  @override
  String get paywallTerms => 'Termos';
  @override
  String get paywallSearchFree =>
      'Buscar na sua própria memória é grátis, sempre. O Premium nunca '
      'bloqueia o que você já tem.';
  @override
  String get paywallNotWiredNote => 'As compras chegam com a versão da loja.';

  @override
  String get back => 'Voltar';
  @override
  String get moreActions => 'Mais ações';
  @override
  String get done => 'Concluído';
  @override
  String get apply => 'Aplicar';
  @override
  String get continueCta => 'Continuar';
  @override
  String get searchAction => 'Buscar';
  @override
  String get sortBy => 'Ordenar por';
  @override
  String get listening => 'Ouvindo…';
  @override
  String get alwaysOn => 'Sempre ativo';
  @override
  String get clearDateFilter => 'Limpar filtro de data';
  @override
  String get sectionGeneral => 'Geral';
  @override
  String get sectionIntelligence => 'Inteligência';
  @override
  String get sectionData => 'Dados';
  @override
  String get productName => 'Universal Search';
  @override
  String get manualAddSource => 'Adicionado por você';
  @override
  String get addedJustNow =>
      'Adicionado agora mesmo — o JARA está deixando isso pesquisável.';

  @override
  String errorTitle(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'O JARA precisa da sua permissão',
        JaraError.fileUnreadable => 'Este arquivo não abre',
        JaraError.indexingFailed => 'A indexação parou antes do fim',
        JaraError.accountDisconnected => 'A conta precisa ser reconectada',
        JaraError.noConnection => 'Você está offline',
        JaraError.localModelNotReady => 'Ainda estamos preparando tudo',
        JaraError.storageFull => 'Não há mais espaço neste dispositivo',
        JaraError.sourceMissing => 'O original não existe mais',
        JaraError.generic => 'Algo precisa ser tentado de novo',
      };

  @override
  String errorBody(JaraError e) => switch (e) {
        JaraError.permissionDenied =>
          'Permita o acesso a esta fonte e ela ficará pesquisável na hora.',
        JaraError.fileUnreadable =>
          'O arquivo pode estar corrompido ou em um formato que o JARA '
              'ainda não lê.',
        JaraError.indexingFailed =>
          'Alguns itens não foram adicionados. Sua memória atual não foi '
              'afetada.',
        JaraError.accountDisconnected =>
          'Faça login novamente para manter os itens desta conta '
              'atualizados.',
        JaraError.noConnection =>
          'Sua memória no dispositivo continua funcionando. Os recursos '
              'na nuvem voltarão automaticamente.',
        JaraError.localModelNotReady =>
          'A busca no dispositivo está terminando de ser configurada. '
              'Isso leva um instante na primeira vez.',
        JaraError.storageFull =>
          'Libere um espaço para o JARA terminar de indexar.',
        JaraError.sourceMissing =>
          'Este item foi movido ou excluído no aplicativo original.',
        JaraError.generic =>
          'Isso não foi concluído. Sua memória está segura — tente de '
              'novo.',
      };

  @override
  String? errorCta(JaraError e) => switch (e) {
        JaraError.permissionDenied => 'Abrir configurações',
        JaraError.fileUnreadable => null,
        JaraError.indexingFailed => 'Tentar novamente',
        JaraError.accountDisconnected => 'Reconectar',
        JaraError.noConnection => null,
        JaraError.localModelNotReady => null,
        JaraError.storageFull => 'Gerenciar armazenamento',
        JaraError.sourceMissing => 'Remover da memória',
        JaraError.generic => 'Tentar novamente',
      };

  @override
  String get needsConnection => 'Requer conexão';

  @override
  String get emptyResultsTitle => 'Ainda não há correspondências';
  @override
  String get emptyResultsBody =>
      'Tente mudar a data, a fonte ou as palavras usadas.';
  @override
  String get emptyResultsAdjust => 'Ajustar filtros';
  @override
  String get emptyResultsSearchAll => 'Buscar em toda a memória';
  @override
  String get emptyMemoryTitle => 'Sua memória começa aqui';
  @override
  String get emptyMemoryBody =>
      'Adicione um arquivo, uma captura de tela, um link ou uma nota. '
      'O JARA vai deixar isso pesquisável.';
  @override
  String get emptyMemoryCta => 'Adicionar primeira lembrança';
  @override
  String get offlineLabel => 'A busca offline está ativa';
  @override
  String get offlineBody =>
      'Sua memória no dispositivo continua funcionando. Os recursos na '
      'nuvem voltarão automaticamente.';
  @override
  String get errorGenericTitle => 'Algo precisa ser tentado de novo';
  @override
  String get errorGenericBody =>
      'Isso não foi concluído. Sua memória está segura — tente de novo.';
  @override
  String get retry => 'Tentar novamente';

  @override
  String get shareTitle => 'Salvar no JARA';
  @override
  String get shareSaveInstantly => 'Salvar instantaneamente';
  @override
  String get shareReview => 'Revisar detalhes';
  @override
  String get shareSaved => 'Salvo na sua memória';

  @override
  String get today => 'Hoje';
  @override
  String get tomorrow => 'Amanhã';
  @override
  String get yesterday => 'Ontem';
  @override
  String daysAgo(int days) => days == 1 ? 'há 1 dia' : 'há $days dias';
  @override
  String inDays(int days) => days == 1 ? 'em 1 dia' : 'em $days dias';
  @override
  String minutesAgo(int m) =>
      m == 1 ? 'há 1 minuto' : 'há $m minutos';
  @override
  String hoursAgo(int h) => h == 1 ? 'há 1 hora' : 'há $h horas';
}
