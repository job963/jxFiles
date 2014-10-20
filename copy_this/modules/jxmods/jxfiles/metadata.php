<?php

/**
 * Metadata version
 */
$sMetadataVersion = '1.1';
 
/**
 * Module information
 */
$aModule = array(
    'id'           => 'jxfiles',
    'title'        => 'jxFiles - File Administration',
    'description'  => array(
                        'de' => 'Modul für die Verwaltung von Dateien.',
                        'en' => 'Module for Managing of Files.'
                        ),
    'thumbnail'    => 'jxfiles.png',
    'version'      => '0.2.1',
    'author'       => 'Joachim Barthel',
    'url'          => 'https://github.com/job963/jxFiles',
    'email'        => 'jobarthel@gmail.com',
    'extend'       => array(
                        ),
    'files'        => array(
                        'jxfiles' => 'jxmods/jxfiles/application/controllers/admin/jxfiles.php'
                        ),
    'templates'    => array(
                        'jxfiles.tpl' => 'jxmods/jxfiles/application/views/admin/tpl/jxfiles.tpl'
                        ),
    'settings' => array(
                        array(
                                'group' => 'JXFILES_DIRECTORIES1', 
                                'name'  => 'sJxFilesDir1Path', 
                                'type'  => 'str', 
                                'value' => 'out/azure/img'
                                ),
                        array(
                                'group' => 'JXFILES_DIRECTORIES1', 
                                'name'  => 'sJxFilesDir1Title', 
                                'type'  => 'str', 
                                'value' => 'Theme-Images'
                                ),
                        array(
                                'group' => 'JXFILES_DIRECTORIES2', 
                                'name'  => 'sJxFilesDir2Path', 
                                'type'  => 'str', 
                                'value' => ''
                                ),
                        array(
                                'group' => 'JXFILES_DIRECTORIES2', 
                                'name'  => 'sJxFilesDir2Title', 
                                'type'  => 'str', 
                                'value' => ''
                                ),
                        array(
                                'group' => 'JXFILES_DIRECTORIES3', 
                                'name'  => 'sJxFilesDir3Path', 
                                'type'  => 'str', 
                                'value' => ''
                                ),
                        array(
                                'group' => 'JXFILES_DIRECTORIES3', 
                                'name'  => 'sJxFilesDir3Title', 
                                'type'  => 'str', 
                                'value' => ''
                                ),
                        array(
                                'group' => 'JXFILES_DIRECTORIES4', 
                                'name'  => 'sJxFilesDir4Path', 
                                'type'  => 'str', 
                                'value' => ''
                                ),
                        array(
                                'group' => 'JXFILES_DIRECTORIES4', 
                                'name'  => 'sJxFilesDir4Title', 
                                'type'  => 'str', 
                                'value' => ''
                                ),
                        array(
                                'group' => 'JXFILES_DIRECTORIES5', 
                                'name'  => 'sJxFilesDir5Path', 
                                'type'  => 'str', 
                                'value' => ''
                                ),
                        array(
                                'group' => 'JXFILES_DIRECTORIES5', 
                                'name'  => 'sJxFilesDir5Title', 
                                'type'  => 'str', 
                                'value' => ''
                                ),
                        )
    );

?>
