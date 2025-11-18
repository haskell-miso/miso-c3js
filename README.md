🍜 📈 miso-c3.js
====================

This project demonstrates an integration between [miso](https://github.com/dmjio/miso) and the [c3.js](https://www.c3js.org/) library. See [live](https://c3js.haskell-miso.org).

<a href="https://c3js.haskell-miso.org">
  <img width="1006" height="347" alt="image" src="https://github.com/user-attachments/assets/7edaafea-078e-4334-be72-73fe099ad1cd" />
</a>

######

> [!TIP] 
> This requires installing [nix](https://nixos.org) with [Nix Flakes](https://wiki.nixos.org/wiki/Flakes) enabled.
> Although not required, we recommend using [miso's binary cache](https://github.com/dmjio/miso?tab=readme-ov-file#binary-cache).

### Development

Call `nix develop` to enter a shell with [GHC 9.12.2](https://haskell.org/ghc)

```bash
$ nix develop --experimental-features nix-command --extra-experimental-features flakes
```

Once in the shell, you can call `cabal run` to start the development server and view the application at http://localhost:8080

### Build (Web Assembly)

```bash
$ nix develop .#wasm --command bash -c "make"
```

### Build (JavaScript)

```bash
$ nix develop .#ghcjs
$ build app
```

### Serve

To host the built application you can call `serve`

```bash
$ nix develop .#wasm --command bash -c "make serve"
```

### Clean

```bash
$ nix develop --command bash -c "make clean"
```

This comes with a GitHub action that builds and auto hosts the example.
