## Classe app\models\Connection.php

Perfeito, Luiz! Se você quiser usar variáveis de ambiente sem depender de bibliotecas externas como o `phpdotenv`, pode seguir uma abordagem nativa usando a função `parse_ini_file()` ou `getenv()` com um arquivo `.env`.

A seguir, vou te mostrar um exemplo funcional e limpo, usando `parse_ini_file()` com um arquivo `.env` (formato INI).

---

### ✅ 1. Crie o arquivo `.env` na raiz do projeto

```ini
DB_HOST=localhost
DB_NAME=store
DB_USER=root
DB_PASS=
DB_CHARSET=utf8mb4
```

---

### ✅ 2. Crie a classe `Connection.php` usando `parse_ini_file`

```php
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

            $host = $env['DB_HOST'] ?? 'localhost';
            $dbname = $env['DB_NAME'] ?? 'store';
            $user = $env['DB_USER'] ?? 'root';
            $pass = $env['DB_PASS'] ?? '';
            $charset = $env['DB_CHARSET'] ?? 'utf8mb4';

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
```

---

### 🧪 Como testar:

No seu `index.php` (ou onde quiser usar a conexão):

```php
use App\Models\Connection;

$db = Connection::getInstance();
$stmt = $db->query("SELECT * FROM products");
$produtos = $stmt->fetchAll();
```

---

### ✅ Vantagens dessa abordagem:

* Sem bibliotecas externas.
* Você pode usar `.env` como quiser, mas com formato compatível com `parse_ini_file()`.
* Fácil de adaptar e manter.

---

**Explicando a Classe Connection.php**

## 📁 `app/models/Connection.php`

```php
<?php
namespace App\Models;
```

* `<?php` inicia o script PHP.
* `namespace App\Models;` define o **namespace** da classe. Isso organiza melhor os arquivos, evitando conflitos e facilitando o autoload.

---

```php
use PDO;
use PDOException;
```

* Importa as classes `PDO` e `PDOException` da biblioteca interna do PHP.
* Com isso, você pode usar `PDO` diretamente, sem escrever `\PDO`.

---

```php
class Connection
{
    private static ?PDO $instance = null;
```

* Define a **classe Connection**.
* `private static ?PDO $instance = null;`

  * `static`: pertence à classe e não a um objeto.
  * `?PDO`: pode ser do tipo `PDO` ou `null`.
  * Serve para **armazenar a única instância de conexão com o banco**, seguindo o **padrão Singleton**.

---

```php
    private function __construct() {}
    private function __clone() {}
```

* O **construtor é privado**, o que impede a criação direta de objetos via `new Connection()`.
* `__clone()` também é privado para impedir que a instância seja duplicada com `clone`.

📌 Isso é fundamental no **Singleton**, que exige uma única instância.

---

```php
    public static function getInstance(): PDO
```

* Método público e estático que retorna um objeto `PDO`.
* Permite acessar a instância via `Connection::getInstance()`.

---

```php
        if (self::$instance === null) {
```

* Verifica se ainda **não existe** uma conexão.
* Se for a primeira vez, ele cria a instância.

---

```php
            $envFile = dirname(__DIR__, 2) . '/.env';
```

* Define o **caminho até o arquivo `.env`**, que está **dois níveis acima** de `app/models/Connection.php`.
* Exemplo: se `Connection.php` estiver em `app/models`, `dirname(__DIR__, 2)` chega à raiz do projeto.

---

```php
            if (!file_exists($envFile)) {
                die("Arquivo .env não encontrado.");
            }
```

* Verifica se o arquivo `.env` existe.
* Se não existir, encerra o programa com uma mensagem de erro.

---

```php
            $env = parse_ini_file($envFile);
```

* Lê o arquivo `.env` e transforma as variáveis em um **array associativo**.
* Exemplo:

  ```php
  $env['DB_HOST'] === 'localhost';
  ```

---

```php
            $host    = $env['DB_HOST']    ?? 'localhost';
            $dbname  = $env['DB_NAME']    ?? 'store';
            $user    = $env['DB_USER']    ?? 'root';
            $pass    = $env['DB_PASS']    ?? '';
            $charset = $env['DB_CHARSET'] ?? 'utf8mb4';
```

* Atribui as configurações do banco vindas do `.env`.
* Usa o **operador null coalescing `??`** para fornecer um valor padrão caso a variável não exista.

---

```php
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
```

* Tenta criar uma nova instância `PDO` com:

  * **DSN (Data Source Name)** para MySQL, com host, nome do banco e charset.
  * Nome de usuário e senha.
  * Um array de opções:

    * `ERRMODE_EXCEPTION`: Lança exceções em caso de erro.
    * `FETCH_ASSOC`: Retorna resultados como array associativo.
    * `PERSISTENT => false`: Não usa conexões persistentes.

---

```php
            } catch (PDOException $e) {
                die("Erro de conexão: " . $e->getMessage());
            }
```

* Se a conexão falhar, captura a exceção e encerra com uma mensagem de erro.

---

```php
        }
        return self::$instance;
    }
}
```

* Depois de criada, a instância é retornada.
* Se já existir, pula todo o `if` e apenas retorna a instância existente.

---

## ✅ Resultado: como funciona na prática

A primeira chamada de:

```php
$db = Connection::getInstance();
```

* Cria a conexão, lê o `.env`, monta o PDO, e guarda em `self::$instance`.
* Nas próximas chamadas, **retorna a mesma conexão**, economizando recursos.




