<?php

namespace App\Model;

use Nette;
use Nette\Security as NS;

class UsersModel extends Nette\Object implements NS\IAuthenticator
{

    const
        COLUMN_ID = 'id',
        COLUMN_ROLE = 'role';

    /** @var Nette\Database\Context */
    private $database;

    public function __construct(Nette\Database\Context $database)
    {
        $this->database = $database;
    }

    /**
     * Performs an authentication.
     * @return Nette\Security\Identity
     * @throws Nette\Security\AuthenticationException
     */
    public function authenticate(array $credentials)
    {
        // list($username, $password) = $credentials;

        // $row = $this->database->table(self::TABLE_NAME)->where('email', $username)->fetch();

        // if (!$row) {
        //     throw new Nette\Security\AuthenticationException('The username is incorrect.', self::IDENTITY_NOT_FOUND);

        // }

        // $arr = $row->toArray();
        // return new Nette\Security\Identity($row[self::COLUMN_ID], $row[self::COLUMN_ROLE], $arr);
    }


    /**
     * Adds new user.
     * @return void
     */
    public function add($username, $password)
    {
        // try {
        //     $this->database->table(self::TABLE_NAME)->insert(array(
        //         self::COLUMN_NAME => $username,
        //         self::COLUMN_PASSWORD_HASH => Passwords::hash($password),
        //     ));
        // } catch (Nette\Database\UniqueConstraintViolationException $e) {
        //     throw new DuplicateNameException;
        // }
    }

    public function findUser($user)
    {
        $row = $this->database->table('members_member')->where('email', $user->email)->fetch();

        if (!$row) {
            $row = $this->database->table('members_member')->where('google_id', $user->id)->fetch();

            if (!$row) {
                throw new Nette\Security\AuthenticationException('Tvůj účet v databázi neexistuje. Pokud máš pocit, že je to jen chyba v matrixu, napiš na it@bestprague.cz s předmětem "POMOOOC, mě to nefunguje! Co mám dělat??"', self::IDENTITY_NOT_FOUND);
            }
        } else if ($row->role == "guest") {
            throw new Nette\Security\AuthenticationException('Bohužel, nemáš právo nakouknout dovnitř.  Pokud máš pocit, že je to jen chyba v matrixu, napiš na it@bestprague.cz s předmětem "POMOOOC, nemůžu se dostat dovnitř! Co mám dělat??"', self::IDENTITY_NOT_FOUND);
        }
        if ($row->google_image != $user->picture) {
            $row->update(array("google_image" => $user->picture));
        }
        if ($row->google_id == NULL) {
            $row->update(array("google_id" => $user->id));
        }
        return $row;
    }


    public function getUserDetails($user)
    {
        \Tracy\Debugger::enable();
        \Tracy\Debugger::barDump($user);
    }

}