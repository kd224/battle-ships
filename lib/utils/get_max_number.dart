int getMaxNumber(double len) {
  if (len > 50) {
    if (len == 200) {
      return 6;
    } else if (len == 150) {
      return 7;
    } else if (len == 100) {
      return 8;
    }
  } else {
    return 9;
  }

  return 9;
}
