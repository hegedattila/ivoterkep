<?php

namespace System;

class FileHandler {
    const FORMAT_DOC = 'application/msword'; //Microsoft Word file.
    const FORMAT_BIN_EXE = 'application/octet-stream'; //Any binary file_hows file download/save dialog box.
    const FORMAT_PDF = 'application/pdf'; //Adobe Acrobat file.
    const FORMAT_PS_AI_EPS = 'application/postscript'; //PostScript files.
    const FORMAT_RTF = 'application/rtf'; //Rich Text Format.
    const FORMAT_GTAR = 'application/x-gtar'; //Compressed Linux file.
    const FORMAT_GZ = 'application/x-gzip'; //Compressed Linux file.
    const FORMAT_JAR = 'application/x-java-archive'; //Java .jar file.
    const FORMAT_SER = 'application/x-java-serialized-object'; //Java .ser file.
    const FORMAT_CLASS = 'application/x-java-vm'; //Java .class file.
    const FORMAT_TAR = 'application/x-tar'; //Compressed Linux file.
    const FORMAT_ZIP = 'application/zip'; //ZIP compressed file.
    // Audio Type
    const FORMAT_AIFF = 'audio/x-aiff'; //Apple sound file.
    const FORMAT_UA = 'audio/basic'; //Basic 8-bit ULAW file.
    const FORMAT_MID_MIDI = 'audio/x-midi'; //MIDI sound file.
    const FORMAT_WAV = 'audio/x-wav'; //WAV sound file.
    // Image Type
    const FORMAT_BMP = 'image/bmp'; //Bitmap image file.
    const FORMAT_PNG = 'image/png';
    const FORMAT_GIF = 'image/gif'; //Graphics Interchange Format.
    const FORMAT_JPEG_JPG_JPE = 'image/jpeg'; //JPEG is another image compression format.
    const FORMAT_TIFF_TIF = 'image/tiff'; //Tag Image File Format.
    const FORMAT_XBM = 'image/x-xbitmap'; //X bitmap format.
    // Multipart Type
    const FORMAT_GZIP = 'multipart/x-gzip'; //Compressed Linux file.
    const FORMAT_XZIP = 'multipart/x-zip'; //ZIP compressed file.
    // Text Type
    const FORMAT_HTM_HTML = 'text/html'; //HTML file.
    const FORMAT_TXT = 'text/plain'; //Plain text file.
    const FORMAT_RTF_RTX = 'text/richtext'; //Rich text format.
    // Video Type
    const FORMAT_MPG_MPEG_MPE = 'video/mpeg'; //MPEG compressed video.
    const FORMAT_VIV_VIVO = 'video/vnd.vivo'; //VIVO video codec.
    const FORMAT_QT_MOV = 'video/quicktime'; //Apple's QuickTime format.
    const FORMAT_AVI = 'video/x-msvideo'; //Microsoft's video format.
    
    
    
    public static function makedir($dir) {
        try {
            if(!is_dir($dir)){
                mkdir($dir);
            }
            return true;
        } catch (Exception $exc) { 
            return false;
        }
    }
}
