class ClsConversorFecha {

  static final meses = [
    "Enero",
    "Febrero",
    "Marzo",
    "Abril",
    "Mayo",
    "Junio",
    "Julio",
    "Agosto",
    "Septiembre",
    "Octubre",
    "Noviembre",
    "Diciembre"
  ];

  static convertirParaLectura(DateTime mFecha) {
    int dia = mFecha.day;
    int mes = mFecha.month;
    int anio = mFecha.year;

    if (mFecha == null) return;
    return "$dia de ${meses[mes - 1]} de $anio";
  }

  static convertirParaLecturaYHora(DateTime mFecha) {
    int dia = mFecha.day;
    int mes = mFecha.month;
    int anio = mFecha.year;

    int hora = mFecha.hour;
    int minuto = mFecha.minute;
    int segundo = mFecha.second;

    if (mFecha == null) return;
    return "$dia de ${meses[mes - 1]} de $anio - $hora:${frmNum(minuto)}:${frmNum(segundo)}";
  }

  static convertirParaApi(DateTime mFecha) {
    int dia = mFecha.day;
    int mes = mFecha.month;
    int anio = mFecha.year;

    if (mFecha == null) return;
    print("FECHA API");
    print("$anio-${frmNum(mes)}-${frmNum(dia)}");
    return "$anio-${frmNum(mes)}-${frmNum(dia)}";
  }

  static convertirFechaParaEnvio(DateTime mFecha) {
    int dia = mFecha.day;
    int mes = mFecha.month;
    int anio = mFecha.year;
    int hora = mFecha.hour;
    int minuto = mFecha.minute;
    int segundo = mFecha.second;

    return "$anio-${frmNum(mes)}-${frmNum(dia)}T${frmNum(hora)}:${frmNum(minuto)}:${frmNum(segundo)}.0000000-04:00";
  }

  static String frmNum(int numero) {
    if (numero < 10 && numero >= 0) 
      return "0${numero.toString()}";
    
    return numero.toString();
  }
}