String buildWeatherIcon(String icon, {bool sizeBig = true}) {
  if (sizeBig) {
    return 'https://openweathermap.org/img/wn/$icon@2x.png';
  } else {
    return 'https://openweathermap.org/img/wn/$icon.png';
  }
}
