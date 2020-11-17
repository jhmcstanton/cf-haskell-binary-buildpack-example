# cloud-foundry-haskell-binary-buildpack-example

This is just an example repo for working with the cloud foundry
[binary buildpack](https://docs.cloudfoundry.org/buildpacks/binary/index.html)
with `haskell`. You should be able to follow this example for whatever language
you are using that requires this buildpack.

## Requirements

There are really only 2 main requirements for this buildpack in general:

- binary is built for your underlying stemcells (probably a linux flavor)
- the binary is statically linked and does not depend on any underlying environment
  from the stemcell
  
Luckily for haskell users `stack` has decent docker support so binaries can
be easily built in a docker context. Then  statically linking a binary with `ghc` can be
accomplished with the flag `-optl-static -optl-pthread`, your language probably has similar flags.

## Usage

This incantation will build the project, including statically linking it, and copy
the binary to `./cf_target`
```sh
stack install --ghc-options='-optl-static -optl-pthread' --local-bin-path ./cf_target
```

Alternatively you could create a Docker image for building your artifact or build
your artifact in your CI/CD solution.

## Push the Artifact

The provided manifest pins the buildpack to the binary buildpack\* and pulls the binary from
`./cf_target/`. 

```sh
cf login <your foundation>
cf target -o <org> -s <space>
cf push
```

\* Your foundation may have different buildpack names than mine. If you have issues check this.

## Boom! Done

That's it! The trickiest parts are:

- setting up a build process (probably already handled by your CI/CD solution)
- ensuring your binary is statically linked
