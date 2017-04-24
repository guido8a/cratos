package cratos.utilitarios

class UtilitarioService {

    def getLastDayOfMonth(fecha) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(fecha);

        calendar.add(Calendar.MONTH, 1);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        calendar.add(Calendar.DATE, -1);

        Date lastDayOfMonth = calendar.getTime();
        return lastDayOfMonth
    }

    def serviceMethod() {

    }
}
