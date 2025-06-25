<?php
namespace App\Models;

use PDO;
use PDOException;

class Connection
{
    private static ?PDO $instance = null;

    private function __construct() {}
    private function __clone() {}

    public static function getInstance(): PDO
    {
        if (self::$instance === null) {
            $envFile = dirname(__DIR__, 2) . '/.env';

            if (!file_exists($envFile)) {
                die("Arquivo .env não encontrado.");
            }

            $env = parse_ini_file($envFile);

            $host =    $env['HOST'] ?? 'localhost';
            $dbname =  $env['DB']   ?? 'store';
            $user =    $env['USER'] ?? 'root';
            $pass =    $env['PASS'] ?? '';
            $charset = $env['CHAR'] ?? 'utf8mb4';

            try {
                self::$instance = new PDO(
                    "mysql:host=$host;dbname=$dbname;charset=$charset",
                    $user,
                    $pass,
                    [
                        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                        PDO::ATTR_PERSISTENT => false,
                    ]
                );
            } catch (PDOException $e) {
                die("Erro de conexão: " . $e->getMessage());
            }
        }

        return self::$instance;
    }
}
