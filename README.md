# Laboratórios de Informática I

## Demo

https://user-images.githubusercontent.com/49988070/210126385-5422d8ed-aa8e-4d65-b4f0-81b8a62927c6.mp4
###### Se estás no GitLab (ou por outro motivo isto é só um link), ou vais ao [GitHub](https://github.com/Darguima/Trivial-Road#demo), vês o ficheiro original ([GitHub](https://github.com/Darguima/Trivial-Road/blob/main/readme/demo.mp4) [GitLab](https://gitlab.com/uminho-di/li1/2223/projetos/2022li1g031/blob/main/readme/demo.mp4)), ou simplesmente abre o link.

Também podes sempre contar com umas fotos

<h1 align="center">
  <img src="./readme/demo_jogo.png" style='width: 80%'/>
  <img src="./readme/demo_creditos.png" style='width: 45%'/>
  <img src="./readme/demo_landing.png" style='width: 45%'/>
</h1>


## Repositório

Se tiver chave SSH configurada no GitLab pode fazer clone com o seguinte link:

```bash
$ git clone git@gitlab.com:uminho-di/li1/2223/2022li1g031.git
$ cd 2022li1g031
```

Alternativamente, pode fazer clone por https com o seguinte link:

```bash
$ git clone https://gitlab.com/uminho-di/li1/2223/projetos/2022li1g031.git
$ cd 2022li1g031
```

## Interpretador

Pode abrir o interpretador do Haskell (GHCi) utilizando o cabal ou diretamente
o interpretador.

1. Usando o `cabal`

```bash
$ cabal repl
```

2. Usando o GHCi

```bash
$ ghci -i="src" -i="tests" src/Main.hs
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
