# Git - O básico para se trabalhar

**Login do usuário GitHubCLI**
```bash
gh auth login
```
**Lista todos os repositórios remotos**
```bash
gh repo list NOME_DO_USUARIO --limit 1000

# Exibe o nome dos repositórios remotos sem exibir suas descrições
gh repo list NOME_DO_USUARIO --limit 1000 --json name -q '.[].name'
```
**Criação do repositório remoto através do GitHubCLI**
```bash
gh repo create php-store --public --source=. --remote=origin --push 
```
**Excluir o repositório remoto através do GitHubCLI**
```bash
# Libera a exclusão
 gh auth refresh -h github.com -s delete_repo

# --yes: exclui sem pedir confirmação  
gh repo delete lpf-developer/php-test --yes
```
**Criação do repositório local**
```bash
git init
```
<div style="page-break-before:always"></div>

**Lista todas as configurações**
```bash
git config --list
```
**Credenciais do usuário GIT**
```bash
# Credenciais de nível local
git config user.name "lpfree"
git config user.email "lpfree76@gmail.com"

# Credenciais a nível global
git config --global user.name "lpfree"
git config --global user.email "lpfree76@gmail.com"

# Remove credenciais globais
git config --global --unset user.name
git config --global --unset user.email

# Remove credenciais locais
git config --unset user.name
git config --unset user.email
```
<div style="page-break-before:always"></div>

**Renomear a ramificação principal de "master" para "main"**
```bash
git branch -M main # -M força o renomear da branch
```
**Cria uma nova branch e se muda para ela**
```bash
git switch -c nova-branch # Comando moderno
git checkout -b nova-branch # Comando tradicional
```
**Adicionar todos os arquivos ao commit**
```bash
git add .
```
**Cria o commit dos arquivos (versionamento)**
```bash
git commit -m "nome do commit"
```
**Excluir o commit antes do push**
```bash

# Voltar ao estado antes do commit (mantendo alterações no código):
git reset --soft HEAD~1

# Voltar ao estado antes do commit (removendo as alterações):
git reset --hard HEAD~1
```
**Conectar o repositório local ao repositório remoto**
```bash
git remote add origin http//:github.com/lpf-developer/store.git
```
**Enviar a versão dos arquivos para o repositório remoto**
```bash
git push -u origin main
```
<div style="page-break-before:always"></div>

**Para listar todas as branchs depois do commit**
```bash
git branch -a # branchs locais e remotas
git branch -v # branchs em detalhes
git branch # todas as branchs locais

```
**Para enviar uma determinada branch para o repositório remoto**
```bash
git push origin nome-da-branch
```
**Para unir as branchs (merge)**
```bash
# Posicione-se na branch que vai receber as demais (destino) e digite:
git merge nome-da-branch-de-origem
```
**Excluir as demais branchs após o merge**
```bash
git branch -d nome-da-branch
```
**Para renomear uma branch, estando dentro dela**
```bash
git branch -m novo-nome-branch
```
**Para renomear uma branch, sem estar dentro dela**
```bash
git branch -m nome-antigo novo-nome
```
**Excluir todas as branchs, mantendo a principal**
```bash
git branch | grep -v "main" | xargs git branch -D
```
