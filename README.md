# Laboratórios de Informática I

## Demo

https://user-images.githubusercontent.com/49988070/210379668-3602bce1-2cd6-43e8-901b-61e537cb54d5.mp4

###### Se estás no GitLab (ou por outro motivo isto é só um link), ou vais ao [GitHub](https://github.com/Darguima/Trivial-Road#demo), vês o ficheiro original ([GitHub](https://github.com/Darguima/Trivial-Road/blob/main/readme/demo.mp4) [GitLab](https://gitlab.com/uminho-di/li1/2223/projetos/2022li1g031/blob/main/readme/demo.mp4)), ou simplesmente abre o link.

Também podes sempre contar com umas fotos

<h1 align="center">
  <img src="./readme/demo_jogo.png" style='width: 80%'/>
  <img src="./readme/demo_creditos.png" style='width: 45%'/>
  <img src="./readme/demo_landing.png" style='width: 45%'/>
</h1>

### GamePad

O jogo é compatível com GamePads :)

###### Mentira, basta dares remap do comando com [`qjoypad`](https://github.com/panzi/qjoypad) para as teclas que usas

https://user-images.githubusercontent.com/49988070/211230247-414fadf8-816c-45dc-8da8-826a0fe67c37.mp4

## Download 📥📲

Podes transferir este jogo nas [releases do GitHub](https://github.com/Darguima/Trivial-Road/releases).

## Repositório

Para clonar o repositório usa um dos seguintes comandos

```bash
# Por HTTPS
$ git clone https://gitlab.com/uminho-di/li1/2223/projetos/2022li1g031.git
$ cd 2022li1g031

# Por SSH
$ git clone git@gitlab.com:uminho-di/li1/2223/2022li1g031.git
$ cd 2022li1g031
```

## Compilador

Para compilar o código podes usar o `cabal`:

```bash
$ mkdir TrivialRoad -p
$ rm -r ./dist-newstyle/build &> /dev/null
$ cabal build
$ mv ./src/Main ./TrivialRoad/trivialRoad
$ cp ./assets ./TrivialRoad -r
$ cp ./highscore.txt ./TrivialRoad

# Single Command
$ mkdir TrivialRoad -p; rm -r ./dist-newstyle/build &> /dev/null; cabal build; mv ./src/Main ./TrivialRoad/trivialRoad; cp ./assets ./TrivialRoad -r; cp ./highscore.txt ./TrivialRoad
```

Será gerada uma pasta `TrivialRoad` que contém todos os arquivos necessários para o jogo ser executado.

```bash
# No Linux
$ ./TrivialRoad/trivialRoad
```

Agora podes comprimir a pasta e envia-la para qualquer lado, sem necessidade de teres o Haskell em outros computadores.

## Interpretador

Pode abrir o interpretador do Haskell (GHCi) utilizando o cabal ou diretamente
o interpretador.

1. Usando o `cabal`

```bash
$ cabal repl
>>> main
```

2. Usando o GHCi (na pasta root do projeto)

```bash
$ ghci -i="src" -i="tests" src/Main.hs
>>> main
```

## Testes

O projecto utiliza a biblioteca [HUnit](https://hackage.haskell.org/package/HUnit) para fazer testes unitários.

Pode correr os testes utilizando uma das seguintes alternativas:

1. Usando o `cabal`

```bash
$ cabal test
```

2. Usando o GHCi

```bash
$ ghci -i="src" -i="tests" tests/Spec.hs
>>> runTestsT1 -- Correr os testes tarefa 1
>>> runTestsT2 -- Correr os testes tarefa 2
>>> runTestsT3 -- Correr os testes tarefa 3
>>> runTestsT4 -- Correr os testes tarefa 4
>>> main -- Correr todos os testes
```

3. Usando o wrapper `runhaskell`

```bash
$ runhaskell -i="src" -i="tests" tests/Spec.hs
```

## Documentação

Pode gerar a documentação com o [Haddock](https://haskell-haddock.readthedocs.io/).

1. Usando o `cabal`

```bash
$ cabal haddock --haddock-all
```

2. Usando diretamente o `haddock`

```bash
$ haddock -h -o doc/html src/*.hs
```

## Grupo 31

- **A104537** Afonso Gonçalves Pedreira;
- **A104344** Dário Silva Guimarães ;
