public class PruebaDrive_ctrl {
    public List<Google_JsonWebToken.Archivo> archivos {get; set;}
    public PruebaDrive_ctrl() {
        Google_JSONWebToken cls = new Google_JSONWebToken();
        cls.init();
        archivos = cls.obtenerUrls('0BzLlAZOUKIAkaXZYbHo5bG9QQUE', 'FOTO PRINCIPAL.jpg');
    }
}