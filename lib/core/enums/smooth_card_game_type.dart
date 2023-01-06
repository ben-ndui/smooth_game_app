enum SmoothCardGameSymbole {
  pique,
  trefle,
  carreau,
  coeur,
  undefined,
}

enum SmoothCardGameColor {
  black,
  red,
  undefined,
}

enum SmoothCardGameName {
  dame,
  valet,
  king,
  as,
  lambda,
}

SmoothCardGameName smoothCardGameNameFromString(String str) {
  switch (str) {
    case 'dame':
      return SmoothCardGameName.dame;
    case 'king':
      return SmoothCardGameName.king;
    case 'valet':
      return SmoothCardGameName.valet;
    case 'as':
      return SmoothCardGameName.as;
    case 'lambda':
      return SmoothCardGameName.lambda;
    default:
      return SmoothCardGameName.lambda;
  }
}

SmoothCardGameColor smoothCardGameColorFromString(String str) {
  switch (str) {
    case 'black':
      return SmoothCardGameColor.black;
    case 'red':
      return SmoothCardGameColor.red;
    default:
      return SmoothCardGameColor.undefined;
  }
}

SmoothCardGameSymbole smoothCardGameSymboleFromString(String str) {
  switch (str) {
    case 'carreau':
      return SmoothCardGameSymbole.carreau;
    case 'pique':
      return SmoothCardGameSymbole.pique;
    case 'trefle':
      return SmoothCardGameSymbole.trefle;
    case 'coeur':
      return SmoothCardGameSymbole.coeur;
    default:
      return SmoothCardGameSymbole.undefined;
  }
}
