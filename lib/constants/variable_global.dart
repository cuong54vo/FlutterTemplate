class VariableGlobal {
  static const bestSalesPeriodList = [
    {
      'id': '1',
      'name': 'January',
    },
    {
      'id': '2',
      'name': 'February',
    },
    {
      'id': '3',
      'name': 'March',
    },
    {
      'id': '4',
      'name': 'April',
    },
    {
      'id': '5',
      'name': 'May',
    },
    {
      'id': '6',
      'name': 'June',
    },
    {
      'id': '7',
      'name': 'July',
    },
    {
      'id': '8',
      'name': 'August',
    },
    {
      'id': '9',
      'name': 'September',
    },
    {
      'id': '10',
      'name': 'October',
    },
    {
      'id': '11',
      'name': 'November',
    },
    {
      'id': '12',
      'name': 'December',
    },
  ];
  static const fulfillmentList = [
    {
      'id': 'fba',
      'name': 'FBA',
    },
    {
      'id': 'fbm',
      'name': 'FBM',
    },
  ];
  static const competitorRevenueList = [
    {
      'id': 'more_than_2000',
      'name': 'More than 2000',
    },
    {
      'id': 'more_than_5000',
      'name': 'More than 5000',
    },
    {
      'id': 'more_than_10000',
      'name': 'More than 10000',
    },
    {
      'id': 'more_than_15000',
      'name': 'More than 15000',
    },
  ];
  static const competitorReviewsList = [
    {
      'id': 'less_than_40',
      'name': 'Less than 40',
    },
    {
      'id': 'less_than_80',
      'name': 'Less than 80',
    },
    {
      'id': 'less_than_150',
      'name': 'Less than 150',
    },
    {
      'id': 'less_than_250',
      'name': 'Less than 250',
    },
  ];
  static const competitorRatingsList = [
    {
      'id': 'less_than_3',
      'name': 'Less than 3.0',
    },
    {
      'id': 'less_than_35',
      'name': 'Less than 3.5',
    },
    {
      'id': 'less_than_4',
      'name': 'Less than 4.0',
    },
    {
      'id': 'less_than_425',
      'name': 'Less than 4.25',
    },
  ];
  static const stopWord = [
    'a',
    'able',
    'about',
    'above',
    'abroad',
    'according',
    'accordingly',
    'across',
    'actually',
    'adj',
    'after',
    'afterwards',
    'again',
    'against',
    'ago',
    'ahead',
    'ain\'t',
    'all',
    'allow',
    'allows',
    'almost',
    'alone',
    'along',
    'alongside',
    'already',
    'also',
    'although',
    'always',
    'am',
    'amid',
    'amidst',
    'among',
    'amongst',
    'an',
    'and',
    'another',
    'any',
    'anybody',
    'anyhow',
    'anyone',
    'anything',
    'anyway',
    'anyways',
    'anywhere',
    'apart',
    'appear',
    'appreciate',
    'appropriate',
    'are',
    'aren\'t',
    'around',
    'as',
    'a\'s',
    'aside',
    'ask',
    'asking',
    'associated',
    'at',
    'available',
    'away',
    'awfully',
    'b',
    'back',
    'backward',
    'backwards',
    'be',
    'became',
    'because',
    'become',
    'becomes',
    'becoming',
    'been',
    'before',
    'beforehand',
    'begin',
    'behind',
    'being',
    'believe',
    'below',
    'beside',
    'besides',
    'best',
    'better',
    'between',
    'beyond',
    'both',
    'brief',
    'but',
    'by',
    'c',
    'came',
    'can',
    'cannot',
    'cant',
    'can\'t',
    'caption',
    'cause',
    'causes',
    'certain',
    'certainly',
    'changes',
    'clearly',
    'c\'mon',
    'co',
    'co.',
    'com',
    'come',
    'comes',
    'concerning',
    'consequently',
    'consider',
    'considering',
    'contain',
    'containing',
    'contains',
    'corresponding',
    'could',
    'couldn\'t',
    'course',
    'c\'s',
    'currently',
    'd',
    'dare',
    'daren\'t',
    'definitely',
    'described',
    'despite',
    'did',
    'didn\'t',
    'different',
    'directly',
    'do',
    'does',
    'doesn\'t',
    'doing',
    'done',
    'don\'t',
    'down',
    'downwards',
    'during',
    'e',
    'each',
    'edu',
    'eg',
    'eight',
    'eighty',
    'either',
    'else',
    'elsewhere',
    'end',
    'ending',
    'enough',
    'entirely',
    'especially',
    'et',
    'etc',
    'even',
    'ever',
    'evermore',
    'every',
    'everybody',
    'everyone',
    'everything',
    'everywhere',
    'ex',
    'exactly',
    'example',
    'except',
    'f',
    'fairly',
    'far',
    'farther',
    'few',
    'fewer',
    'fifth',
    'first',
    'five',
    'followed',
    'following',
    'follows',
    'for',
    'forever',
    'former',
    'formerly',
    'forth',
    'forward',
    'found',
    'four',
    'from',
    'further',
    'furthermore',
    'g',
    'get',
    'gets',
    'getting',
    'given',
    'gives',
    'go',
    'goes',
    'going',
    'gone',
    'got',
    'gotten',
    'greetings',
    'h',
    'had',
    'hadn\'t',
    'half',
    'happens',
    'hardly',
    'has',
    'hasn\'t',
    'have',
    'haven\'t',
    'having',
    'he',
    'he\'d',
    'he\'ll',
    'hello',
    'help',
    'hence',
    'her',
    'here',
    'hereafter',
    'hereby',
    'herein',
    'here\'s',
    'hereupon',
    'hers',
    'herself',
    'he\'s',
    'hi',
    'him',
    'himself',
    'his',
    'hither',
    'hopefully',
    'how',
    'howbeit',
    'however',
    'hundred',
    'i',
    'i\'d',
    'ie',
    'if',
    'ignored',
    'i\'ll',
    'i\'m',
    'immediate',
    'in',
    'inasmuch',
    'inc',
    'inc.',
    'indeed',
    'indicate',
    'indicated',
    'indicates',
    'inner',
    'inside',
    'insofar',
    'instead',
    'into',
    'inward',
    'is',
    'isn\'t',
    'it',
    'it\'d',
    'it\'ll',
    'its',
    'it\'s',
    'itself',
    'i\'ve',
    'j',
    'just',
    'k',
    'keep',
    'keeps',
    'kept',
    'know',
    'known',
    'knows',
    'l',
    'last',
    'lately',
    'later',
    'latter',
    'latterly',
    'least',
    'less',
    'lest',
    'let',
    'let\'s',
    'like',
    'liked',
    'likely',
    'likewise',
    'little',
    'look',
    'looking',
    'looks',
    'low',
    'lower',
    'ltd',
    'm',
    'made',
    'mainly',
    'make',
    'makes',
    'many',
    'may',
    'maybe',
    'mayn\'t',
    'me',
    'mean',
    'meantime',
    'meanwhile',
    'merely',
    'might',
    'mightn\'t',
    'mine',
    'minus',
    'miss',
    'more',
    'moreover',
    'most',
    'mostly',
    'mr',
    'mrs',
    'much',
    'must',
    'mustn\'t',
    'my',
    'myself',
    'n',
    'name',
    'namely',
    'nd',
    'near',
    'nearly',
    'necessary',
    'need',
    'needn\'t',
    'needs',
    'neither',
    'never',
    'neverf',
    'neverless',
    'nevertheless',
    'new',
    'next',
    'nine',
    'ninety',
    'no',
    'nobody',
    'non',
    'none',
    'nonetheless',
    'noone',
    'no-one',
    'nor',
    'normally',
    'not',
    'nothing',
    'notwithstanding',
    'novel',
    'now',
    'nowhere',
    'o',
    'obviously',
    'of',
    'off',
    'often',
    'oh',
    'ok',
    'okay',
    'old',
    'on',
    'once',
    'one',
    'ones',
    'one\'s',
    'only',
    'onto',
    'opposite',
    'or',
    'other',
    'others',
    'otherwise',
    'ought',
    'oughtn\'t',
    'our',
    'ours',
    'ourselves',
    'out',
    'outside',
    'over',
    'overall',
    'own',
    'p',
    'particular',
    'particularly',
    'past',
    'per',
    'perhaps',
    'placed',
    'please',
    'plus',
    'possible',
    'presumably',
    'probably',
    'provided',
    'provides',
    'q',
    'que',
    'quite',
    'qv',
    'r',
    'rather',
    'rd',
    're',
    'really',
    'reasonably',
    'recent',
    'recently',
    'regarding',
    'regardless',
    'regards',
    'relatively',
    'respectively',
    'right',
    'round',
    's',
    'said',
    'same',
    'saw',
    'say',
    'saying',
    'says',
    'second',
    'secondly',
    'see',
    'seeing',
    'seem',
    'seemed',
    'seeming',
    'seems',
    'seen',
    'self',
    'selves',
    'sensible',
    'sent',
    'serious',
    'seriously',
    'seven',
    'several',
    'shall',
    'shan\'t',
    'she',
    'she\'d',
    'she\'ll',
    'she\'s',
    'should',
    'shouldn\'t',
    'since',
    'six',
    'so',
    'some',
    'somebody',
    'someday',
    'somehow',
    'someone',
    'something',
    'sometime',
    'sometimes',
    'somewhat',
    'somewhere',
    'soon',
    'sorry',
    'specified',
    'specify',
    'specifying',
    'still',
    'sub',
    'such',
    'sup',
    'sure',
    't',
    'take',
    'taken',
    'taking',
    'tell',
    'tends',
    'th',
    'than',
    'thank',
    'thanks',
    'thanx',
    'that',
    'that\'ll',
    'thats',
    'that\'s',
    'that\'ve',
    'the',
    'their',
    'theirs',
    'them',
    'themselves',
    'then',
    'thence',
    'there',
    'thereafter',
    'thereby',
    'there\'d',
    'therefore',
    'therein',
    'there\'ll',
    'there\'re',
    'theres',
    'there\'s',
    'thereupon',
    'there\'ve',
    'these',
    'they',
    'they\'d',
    'they\'ll',
    'they\'re',
    'they\'ve',
    'thing',
    'things',
    'think',
    'third',
    'thirty',
    'this',
    'thorough',
    'thoroughly',
    'those',
    'though',
    'three',
    'through',
    'throughout',
    'thru',
    'thus',
    'till',
    'to',
    'together',
    'too',
    'took',
    'toward',
    'towards',
    'tried',
    'tries',
    'truly',
    'try',
    'trying',
    't\'s',
    'twice',
    'two',
    'u',
    'un',
    'under',
    'underneath',
    'undoing',
    'unfortunately',
    'unless',
    'unlike',
    'unlikely',
    'until',
    'unto',
    'up',
    'upon',
    'upwards',
    'us',
    'use',
    'used',
    'useful',
    'uses',
    'using',
    'usually',
    'v',
    'value',
    'various',
    'versus',
    'very',
    'via',
    'viz',
    'vs',
    'w',
    'want',
    'wants',
    'was',
    'wasn\'t',
    'way',
    'we',
    'we\'d',
    'welcome',
    'well',
    'we\'ll',
    'went',
    'were',
    'we\'re',
    'weren\'t',
    'we\'ve',
    'what',
    'whatever',
    'what\'ll',
    'what\'s',
    'what\'ve',
    'when',
    'whence',
    'whenever',
    'where',
    'whereafter',
    'whereas',
    'whereby',
    'wherein',
    'where\'s',
    'whereupon',
    'wherever',
    'whether',
    'which',
    'whichever',
    'while',
    'whilst',
    'whither',
    'who',
    'who\'d',
    'whoever',
    'whole',
    'who\'ll',
    'whom',
    'whomever',
    'who\'s',
    'whose',
    'why',
    'will',
    'willing',
    'wish',
    'with',
    'within',
    'without',
    'wonder',
    'won\'t',
    'would',
    'wouldn\'t',
    'x',
    'y',
    'yes',
    'yet',
    'you',
    'you\'d',
    'you\'ll',
    'your',
    'you\'re',
    'yours',
    'yourself',
    'yourselves',
    'you\'ve',
    'z',
    'zero'
  ];
  static const suggestionsList = [
    {
      'id': 'must_have_suggestions',
      'name': 'Must have suggestions',
    },
  ];
  static const correctSpellingList = [
    {
      'id': 'is_correct_spelling',
      'name': 'Is Correct Spelling',
    },
    {
      'id': 'not_correct_spelling',
      'name': 'Not Correct Spelling',
    },
  ];
  static const amazonChoiceList = [
    {
      'id': 'analyzed_product',
      'name': 'Analyzed Product',
    },
    {
      'id': 'other_product',
      'name': 'Other Product',
    },
    {
      'id': 'no_badge',
      'name': 'No Badge',
    },
  ];
  static const matchTypeList = [
    {
      'id': 'organic',
      'name': 'Organic',
    },
    {
      'id': 'sponsored',
      'name': 'Sponsored',
    },
    {
      'id': 'amazon_recommended',
      'name': 'Amazon Recommended',
    },
  ];
  static const keywordSearchList = [
    {
      'id': 'all_criteria',
      'name': 'All Criteria',
    },
    {
      'id': 'keyword',
      'name': 'Keyword',
    },
  ];
  static const keywordSearchTypeList = [
    {
      'id': 'containt',
      'name': 'Containt',
    },
    {
      'id': 'starts_with',
      'name': 'Starts with',
    },
    {
      'id': 'ends_with',
      'name': 'Ends with',
    },
    {
      'id': 'exact_match',
      'name': 'Exact match',
    },
    {
      'id': 'in_comma_delimited_set',
      'name': 'In comma-Delimited set',
    },
    {
      'id': 'word',
      'name': 'Word',
    },
  ];
}
