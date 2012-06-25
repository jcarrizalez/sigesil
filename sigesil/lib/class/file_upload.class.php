<?php
class FileUpload {

    //Variables
    var $allowedTypes = null;
    var $success = '';
    var $message = '';
    var $uploadDir = '';
    var $originalName = '';
    var $finalName = '';
    var $spechar = array("\r\n", "\\", "'", "\t", "\n", "\r", "\0", "\x0B", "%20", " ");

    //constructor: 
    function __construct($types, $dir = '') {
        if (empty($types))
            $this->setAllowedTypes(array('images'));
        else
            $this->setAllowedTypes($types);
        $this->uploadDir = ($dir) ? $dir : APPROOT.'/temp_files/';
    }

    function setAllowedTypes($types) {
        $mime = array();
        foreach ($types as $type) {
            switch ($type) {
                case 'images': array_push($mime, 'image/jpeg', 'image/pjpeg', 'image/png', 'image/gif', 'image/tiff', 'image/x-tiff', 'image/bmp');
                    break;
                case 'product_img': array_push($mime, 'image/jpeg', 'image/pjpeg', 'image/png');
                    break;
                case 'pdf': array_push($mime, 'application/pdf', 'application/x-pdf', 'application/acrobat', 'text/pdf', 'text/x-pdf');
                    break;
                case 'text': $mime[] = 'text/plain';
                    break;
                case 'word': $mime[] = 'application/msword';
                    break;
                case 'powerpoint': array_push($mime, 'application/mspowerpoint', 'application/powerpoint', 'application/vnd.ms-powerpoint', 'application/x-mspowerpoint');
                    break;
                case 'excel': array_push($mime, 'application/x-msexcel', 'application/excel', 'application/x-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
                    break;
                case 'compressed': array_push($mime, 'application/x-compressed', 'application/x-zip-compressed', 'application/zip', 'multipart/x-zip', 'application/x-tar', 'application/x-compressed', 'application/x-gzip', 'application/x-gzip', 'multipart/x-gzip', 'application/octet-stream', 'application/x-gtar');
                    break;
                case 'swf': $mime[] = 'application/x-shockwave-flash';
                    break;
            }
        }
        $this->allowedTypes = $mime;
    }

    function uploadFile($files, $fileInputName, $fileName, $required) {
        //No file was uploaded yet!!!
        $this->success = false;
        // Get the reference
        $uploadedFile = $files["$fileInputName"];
        //Debug::pr($uploadedFile,true);
        $fileExtension = substr($uploadedFile['name'], strrpos($uploadedFile['name'], '.'));
        $this->originalName = $uploadedFile['name'];
        //suceessfully updated and check the filetype
        if (is_uploaded_file($uploadedFile['tmp_name'])) {
            if (in_array($uploadedFile['type'], $this->allowedTypes)) {
                if (move_uploaded_file($uploadedFile['tmp_name'], $this->uploadDir . $fileName . $fileExtension)) {
                    $this->success = true;
                    $this->finalName = $fileName . $fileExtension;
                    $this->message = 'txtFileUploadSuccess';
                } else {
                    $this->success = false;
                    $this->message = 'txtFileUploadError';
                }
            } else {
                $this->success = false;
                $this->message = 'txtFileUploadMimeError';
            }
        } else {
            if ($required) {
                $this->success = false;
                $this->message = 'txtFileUploadRequired';
            } else {
                $this->success = false;
                $this->message = 'txtFileUploadNotRequired';
            }
        }
    }

    function uploadFileResize($files, $fileInputName, $fileName, $required, $width, $height) {
        //No file was uploaded yet!!!
        $this->success = false;
        // Get the reference
        $uploadedFile = $files["$fileInputName"];
        //Debug::pr($uploadedFile,true);
        $fileExtension = substr($uploadedFile['name'], strrpos($uploadedFile['name'], '.'));
        $this->originalName = $uploadedFile['name'];
        //suceessfully updated and check the filetype
        if (is_uploaded_file($uploadedFile['tmp_name'])) {
            if (in_array($uploadedFile['type'], $this->allowedTypes)) {
                //Genera la imagen
                $phpThumb = new phpThumb();
                $phpThumb->resetObject();
                $phpThumb->setSourceFilename($uploadedFile['tmp_name']);
                $phpThumb->setParameter('far', 1);
                $phpThumb->setParameter('bg', '#FFFFFF');
                $phpThumb->setParameter('w', $width);
                $phpThumb->setParameter('h', $height);
                if ($phpThumb->GenerateThumbnail())
                    $phpThumb->RenderToFile($this->uploadDir . $fileName . $fileExtension);

                $this->success = true;
                $this->finalName = $fileName . $fileExtension;
                $this->message = 'txtFileUploadSuccess';
            }
            else {
                $this->success = false;
                $this->message = 'txtFileUploadMimeError';
            }
        } else {
            if ($required) {
                $this->success = false;
                $this->message = 'txtFileUploadRequired';
            } else {
                $this->success = false;
                $this->message = 'txtFileUploadNotRequired';
            }
        }
    }
}
?>