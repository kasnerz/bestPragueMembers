<?php

namespace App\Model;
use Nette;
// use Nette\Environment;


class ImageStorage extends Nette\Object
{
    private $dir;
    private $www_dir;

    public function __construct($dir)
    {
        $this->www_dir = WWW_DIR . "/images/profile";
        $this->dir = $dir;
    }

    private function save($file, $contents)
    {
        file_put_contents($this->www_dir . '/' . $file, $contents);
    }

    private function randColor() {
        return sprintf('%02X%02X%02X', mt_rand(0, 125), mt_rand(0, 125), mt_rand(0, 125));
    }

    private function saveToCache($member, $image) {
         $filename = $member->id_member . '.png';

        $this->save($filename, file_get_contents($image));

        $member->update(array("image" =>$filename));
    }

    public function getProfileImage($member)
    {
        $image = $member->image;

        if ($image === '') {
            if ($member->google_image === '') {
                $nameLetter = substr($member->name, 0, 1);
                $surnameLetter = substr($member->surname, 0, 1);
                $image = "https://dummyimage.com/512x512/" . $this->randColor() . "/fff.png&text=" . $nameLetter . $surnameLetter;
            } else {
                $image = $member->google_image;
            }
        }

        if (substr($image, 0, 4) === 'http') {
            $this->saveToCache($member, $image);
        }

        return $this->dir . '/' . $member->image;
    }
}
