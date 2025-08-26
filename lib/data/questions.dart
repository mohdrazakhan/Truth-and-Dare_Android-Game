// A map to hold all questions, categorized by mode and mood.
const Map<String, Map<String, Map<String, List<String>>>> gameData = {
  'Family': {
    'Truth': {
      'All': [
        'What is your favorite family memory?',
        'If you could have any superpower, what would it be?',
        'What is the nicest thing someone in this room has done for you?',
        'What is your biggest dream?',
      ],
    },
    'Dare': {
      'All': [
        'Do an impression of another family member.',
        'Sing the alphabet backward.',
        'Balance a spoon on your nose for 10 seconds.',
        'Make up a silly handshake with the person to your right.',
      ],
    },
  },
  'Friends': {
    'Truth': {
      'Funny': [
        'What is the silliest thing you have done to get a crush\'s attention?',
        'What is your most embarrassing nickname?',
      ],
      'Hard': [
        'What is a secret you have kept from your parents?',
        'Who is the most annoying person you know?',
      ],
      'Extreme': [
        'What is the biggest lie you have ever told the group?',
        'Have you ever stolen anything?',
      ],
    },
    'Dare': {
      'Funny': [
        'Let the group post a funny status on your social media.',
        'Talk in a robot voice for the next 3 rounds.',
      ],
      'Hard': [
        'Call a random number and try to have a 1-minute conversation.',
        'Show the most embarrassing photo on your phone.',
      ],
      'Extreme': [
        'Let someone in the group send a text to any of your contacts.',
        'Eat a spoonful of a weird food combination the group creates.',
      ],
    },
  },
  'Couples': {
    'Truth': {
      'Funny': [
        'What is your partner\'s most annoying habit?',
        'What was your first impression of your partner?',
      ],
      'Hot': [
        'What is your favorite thing about your partner\'s body?',
        'What is a fantasy you have never told your partner?',
      ],
      'Extreme': [
        'Do you think you could do better than your current partner?',
        'What is the one thing you would change about your partner?',
      ],
    },
    'Dare': {
      'Funny': [
        'Re-enact your first kiss.',
        'Let your partner do your makeup.',
      ],
      'Hot': [
        'Give your partner a 5-minute massage.',
        'Whisper something you want to do to your partner later.',
      ],
      'Extreme': [
        'Swap clothes with your partner for the next 2 rounds.',
        'Slow dance with your partner for one full song.',
      ],
    },
  },
};