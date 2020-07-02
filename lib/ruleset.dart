enum GameRulesNames {
  DoubleOne, // "Tienes que beber 7 tragos",
  KingOfThree,
  Duel,
  INever,
  MakeSomeoneDrink,
  Bisquit,
  CreateRule,
  PreviousOneDrinks,
  YouDrink,
  NextOneDrinks,
  DrinkAllIfYouLie,
  DuelOnly_FirstPlayerWins,
  DuelOnly_SecondPlayerWins,
  DuelOnly_DrawSoBothDrink
}

class GameRulesManager {
  Map<GameRulesNames, String> _mappedRules = new Map();

  GameRulesManager() {
    _mappedRules[GameRulesNames.DoubleOne] =
        'Oh, oh... ¡doble uno significa que bebes SIETE TRAGOS 😲!';
    _mappedRules[GameRulesNames.CreateRule] =
        '¡Hora de LEGISLAR 📑! Escribe una norma sobre cualquier cosa, como beber con sólo la mano derecha, hablar sin una letra, no usar el móvil, etc. Quien rompa la norma, bebe 🥤. Sólo estarán activas las 3 últimas normas que se han hecho.';
    _mappedRules[GameRulesNames.Duel] =
        'Reta a alguien, y haced cada uno una tirada de dados 🎲. El que pierda, bebe tantas veces como el número más alto.';
    _mappedRules[GameRulesNames.INever] =
        '¡El típico juego del "yo nunca"! ¿Acaso hace falta explicar cómo funciona? 😏';
    _mappedRules[GameRulesNames.MakeSomeoneDrink] =
        'Haz beber un trago a otro jugador a tu elección 🥃';
    _mappedRules[GameRulesNames.Bisquit] =
        'Todos en la mesa deben decir "¡Bisquit!" y tocarse la frente con el pulgar 🤚. El último en hacerlo, bebe.';
    _mappedRules[GameRulesNames.KingOfThree] =
        'A partir de ahora, tienes que hacer lo que te toque EL DOBLE de veces 😈. ¿Tienes que beber un trago? Pues ahora dos. ¿Tienes que dar una vuelta sobre ti mismo antes de beber porque lo dice una norma? ¡Pues ahora son dos 😨!';
    _mappedRules[GameRulesNames.PreviousOneDrinks] =
        'Bebe un trago el anterior a ti ⬅️.';
    _mappedRules[GameRulesNames.NextOneDrinks] =
        'Bebe un trago el que va después de ti ➡️.';
    _mappedRules[GameRulesNames.YouDrink] = '¡Te toca beberte un trago 🍹!';
    _mappedRules[GameRulesNames.DrinkAllIfYouLie] =
        'A partir de ahora, si alguien te pilla mintiendo (sobre cualquier cosa) en cualquier momento de la partida... ¡TE BEBES TODA TU COPA 😱!';
    _mappedRules[GameRulesNames.DuelOnly_FirstPlayerWins] =
        'Gana el primer jugador';
    _mappedRules[GameRulesNames.DuelOnly_SecondPlayerWins] =
        'Gana el segundo jugador';
    _mappedRules[GameRulesNames.DuelOnly_DrawSoBothDrink] =
        'Mismo resultado... ¡bebéis ambos 👽!';
  }

  processDiceResult(int result) {
    switch (result) {
      case 2:
        return GameRulesNames.DoubleOne;
      case 3:
        return GameRulesNames.KingOfThree;
      case 4:
        return GameRulesNames.Duel;
      case 5:
        return GameRulesNames.INever;
      case 6:
        return GameRulesNames.MakeSomeoneDrink;
      case 7:
        return GameRulesNames.Bisquit;
      case 8:
        return GameRulesNames.CreateRule;
      case 9:
        return GameRulesNames.PreviousOneDrinks;
      case 10:
        return GameRulesNames.YouDrink;
      case 11:
        return GameRulesNames.NextOneDrinks;
      case 12:
        return GameRulesNames.DrinkAllIfYouLie;
    }
  }

  getLabel(GameRulesNames rule) {
    switch (rule) {
      case GameRulesNames.DoubleOne:
        return "Doble uno 1️⃣1️⃣";
      case GameRulesNames.KingOfThree:
        return "Rey del 3 👑";
      case GameRulesNames.Duel:
        return "Duelo ⚔️";
      case GameRulesNames.INever:
        return "Yo nunca...";
      case GameRulesNames.MakeSomeoneDrink:
        return "¡Manda beber!";
      case GameRulesNames.Bisquit:
        return "¡BISQUIT!";
      case GameRulesNames.CreateRule:
        return "Crea nueva regla ⚖️";
      case GameRulesNames.PreviousOneDrinks:
        return "Bebe el anterior";
      case GameRulesNames.YouDrink:
        return "¡Bebes tú!";
      case GameRulesNames.NextOneDrinks:
        return "Bebe el próximo";
      case GameRulesNames.DrinkAllIfYouLie:
        return "Si mientes, te lo bebes todo";
      case GameRulesNames.DuelOnly_FirstPlayerWins:
        return "Bebe el segundo jugador 🍹";
        break;
      case GameRulesNames.DuelOnly_SecondPlayerWins:
        return "Bebe el primer jugador 🍹";
        break;
      case GameRulesNames.DuelOnly_DrawSoBothDrink:
        return "¡Os toca beber a ambos 🍹!";
        break;
    }
  }

  getDescriptionForRule(GameRulesNames rule) {
    return _mappedRules[rule];
  }
}
