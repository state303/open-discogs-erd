# Changelog

## [2.0.0](https://github.com/state303/open-discogs-erd/compare/v1.4.0...v2.0.0) (2022-12-15)


### ⚠ BREAKING CHANGES

* **release:** moves main release indication to release

### Bug Fixes

* **release:** moves main release indication to release ([afa241f](https://github.com/state303/open-discogs-erd/commit/afa241f8c6ea1d2f7d3acee4249c12309312baf3))

## [1.4.0](https://github.com/state303/open-discogs-erd/compare/v1.3.2...v1.4.0) (2022-12-14)


### Features

* adds created dates for all relations to track ([93d66c8](https://github.com/state303/open-discogs-erd/commit/93d66c8d6b3947a43d5bb6ffbbddf1cf7f3ec493))

## [1.3.2](https://github.com/state303/open-discogs-erd/compare/v1.3.1...v1.3.2) (2022-11-28)


### Bug Fixes

* removes -1 as default values ([7b64a0c](https://github.com/state303/open-discogs-erd/commit/7b64a0cf43feb7eb2f672e11736440c09fa3a207))

## [1.3.1](https://github.com/state303/open-discogs-erd/compare/v1.3.0...v1.3.1) (2022-11-27)


### Bug Fixes

* removes possible collision by hash ([39f8014](https://github.com/state303/open-discogs-erd/commit/39f8014fac6b95a5fc8d42120818a55e1032a07b))

## [1.3.0](https://github.com/state303/open-discogs-erd/compare/v1.2.3...v1.3.0) (2022-11-24)


### Features

* adds changelog to dbml prepend for publish ([226a79f](https://github.com/state303/open-discogs-erd/commit/226a79fb5361a2eafd603b92787e8d4a593f6189))

## [1.2.3](https://github.com/state303/open-discogs-erd/compare/v1.2.2...v1.2.3) (2022-11-23)


### Bug Fixes

* replace release_identifier.value type to TEXT ([1d38c9f](https://github.com/state303/open-discogs-erd/commit/1d38c9fabe53b1f92fa7f30170917abb67342c8b))

## [1.2.2](https://github.com/state303/open-discogs-erd/compare/v1.2.1...v1.2.2) (2022-11-23)


### Bug Fixes

* updates description column for release_identifier to text ([b3f3f6f](https://github.com/state303/open-discogs-erd/commit/b3f3f6f0b162ca30a8fc8a85d9ecec9a7d9de8fb))

## [1.2.1](https://github.com/state303/open-discogs-erd/compare/v1.2.0...v1.2.1) (2022-11-23)


### Bug Fixes

* changes type for hash from int to bigint ([2a562be](https://github.com/state303/open-discogs-erd/commit/2a562be0b72e37ea9b9ed2c30dc406c2f5884def))

## [1.2.0](https://github.com/state303/open-discogs-erd/compare/v1.1.2...v1.2.0) (2022-11-18)


### Features

* adds schema generation for release job ([4416b1a](https://github.com/state303/open-discogs-erd/commit/4416b1a4230bf7b0b21c5dcdbd56091ed92cec8f))


### Bug Fixes

* adds dbml-cli install step on release job ([62e7d87](https://github.com/state303/open-discogs-erd/commit/62e7d8765e833d99eb6cc5bddba9bf22411b661c))

## [1.1.2](https://github.com/state303/open-discogs-erd/compare/v1.1.1...v1.1.2) (2022-11-13)


### Bug Fixes

* set types to more commonly supported one ([0531cd5](https://github.com/state303/open-discogs-erd/commit/0531cd57958c0afd7fa4a1f7d2af55be7e4f178c))

## [1.1.1](https://github.com/state303/open-discogs-erd/compare/v1.1.0...v1.1.1) (2022-11-13)


### Bug Fixes

* typo on note at data.etag ([55d645c](https://github.com/state303/open-discogs-erd/commit/55d645cc953250f6dd37733c2519e3acd0395dab))

## [1.1.0](https://github.com/state303/open-discogs-erd/compare/v1.0.1...v1.1.0) (2022-11-13)


### Features

* adds new table 'data' ([e36ca47](https://github.com/state303/open-discogs-erd/commit/e36ca4732d30a859ec8795fdef836e70209f802f))

## [1.0.1](https://github.com/state303/open-discogs-erd/compare/v1.0.0...v1.0.1) (2022-11-11)


### Bug Fixes

* updates types and namings ([1dba2a5](https://github.com/state303/open-discogs-erd/commit/1dba2a54d66a1a0370429af55c816c3aab763e90))

## 1.0.0 (2022-10-24)


### Features

* initial erd ([331cdc3](https://github.com/state303/open-discogs-erd/commit/331cdc386428c0ea41ee4425c5e4edb69ebe366b))


### Bug Fixes

* project name will now contain spaces ([6015f30](https://github.com/state303/open-discogs-erd/commit/6015f30473d2b9f918693dd829e2eb85cc3f7bad))
* reverts malformed project naming ([7e5fb02](https://github.com/state303/open-discogs-erd/commit/7e5fb02d4d0fef0a6f871bb4cff031a9e9d3a8d0))
