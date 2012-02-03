function hora_sistema(fechaHora){
    fecha = new Date(fechaHora);
    var hora=fecha.getHours();
    var minutos=fecha.getMinutes();
    var segundos=fecha.getSeconds();
    if(hora<10){ hora='0'+hora;}
    if(minutos<10){minutos='0'+minutos; }
    if(segundos<10){ segundos='0'+segundos; }
    fech="<span style='font-weight: bold;'>Hora: "+hora+":"+minutos+":"+segundos+"</span>";
    document.getElementById('hora').innerHTML=fech;
    fecha.setSeconds(fecha.getSeconds()+1);
    setTimeout("hora_sistema(fecha)",1000);
}