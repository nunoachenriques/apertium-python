# Apertium + Python

[![Travis Build Status](https://travis-ci.com/apertium/apertium-python.svg?branch=master)](https://travis-ci.com/apertium/apertium-python)
[![Appveyor Build status](https://ci.appveyor.com/api/projects/status/sesdinoy4cw2p1tk/branch/master?svg=true)](https://ci.appveyor.com/project/apertium/apertium-python/branch/master)
[![ReadTheDocs Docs Status](https://readthedocs.org/projects/apertium-python/badge)](https://readthedocs.org/projects/apertium-python)
[![Coverage Status](https://coveralls.io/repos/github/apertium/apertium-python/badge.svg?branch=master)](https://coveralls.io/github/apertium/apertium-python?branch=master)
[![PyPI - Python Version](https://img.shields.io/pypi/pyversions/apertium.svg)]((https://pypi.org/project/apertium/))

## Introduction

- The codebase is in development for the GSoC '19 project called **Apertium API in Python**
- The Apertium core modules are written in C++.
- This project makes the Apertium modules available in Python, which because of its simplicity is more appealing to users.

## About the Existing Code Base

- The existing codebase has `Subprocess` and [SWIG](http://www.swig.org/) wrapper implementations of the higher level functions of Apertium and CG modules.

## Installation

### User

**NOTICE:** 2023-05-16 fork https://github.com/nunoachenriques/apertium-python

**WARNING:** Installation fails when in Python 3.10 or 3.11, i.e., Python > 3.9!
Moreover, `apertium/installer.py` fails to detect "Debian GNU/Linux 12" as a
Debian release!

- ~~Installation on Debian/Ubuntu and Windows is natively supported~~:

    ```shell
    # pip install apertium
    ```

### Developer

**WARNING:** Installation from lock file fails. Moreover, installation fails
when in Python 3.10 or 3.11, i.e., Python > 3.9!

- ~~For developers, `pipenv` can be used to install the development dependencies and enter a shell with them:~~

    ```shell
    # pip install pipenv
    # pipenv install --dev
    # pipenv shell
    ```

**WORKAROUND:** Trying to build an installable version!
 - Python pinned to max viable version `python_version = "3.9"` in `Pipfile`.
   ```toml
   [requires]
   python_version = "3.9"
   ```
 - Install `pyenv` (e.g., [Basics QA Python](https://github.com/nunoachenriques/basics-qa-python/blob/main/docs/README-Linux.md#pyenv))
   to let `pipenv` automatically manage required Python versions.
   ```shell
   curl https://pyenv.run | bash
   ```
 - Install `pipenv` in a safe environment (using `pipx`) if it is missing. 
   ```shell
   sudo apt install pipx
   pipx ensurepath
   pipx install pipenv
   ```
 - Finally, skip the lock file when installing the environment.
   ```shell
   pipenv install --dev --skip-lock
   ```
**ET VOILÀ !**

- Apertium packages can be installed from Python interpreter as well.
  - Install `apertium-all-dev` by calling `apertium.installer.install_apertium()`
  - Install language packages with `apertium.installer.install_module(language_name)`. For example `apertium-eng` can be installed by executing `apertium.installer.install_module('eng')`

**FURTHERMORE:** To create distribution files (e.g., dist/.tar.gz) a virtual
machine must be in place with a compatible Linux distribution, such as Debian
GNU/Linux 11 Bullseye version because the installer requires some system-wide
packages' installation!

## Usage

**NOTICE:** For multiple invocations **Method 1** is more performant, as the dictionary needs to be loaded only once.

### Analysis

Performing Morphological Analysis

Method 1: Create an `Analyzer` object and call its `analyze` method.
```python
import apertium
a = apertium.Analyzer('en')
a.analyze('cats')
```
```
[cats/cat<n><pl>, ./.<sent>]
```

Method 2: Calling `analyze()` directly.
```python
import apertium
apertium.analyze('en', 'cats')
```
```
cats/cat<n><pl>
```

### Generation

Performing Morphological Generation

Method 1:  Create a `Generator` object and call its `generate` method.
```python
import apertium
g = apertium.Generator('en')
g.generate('^cat<n><pl>$')
```
```
'cats'
```

Method 2: Calling `generate()` directly.
```python
import apertium
apertium.generate('en', '^cat<n><pl>$')
```
```
'cats'
```

### Tagger

Method 1:  Create a `Tagger` object and call its `tag` method.
```python
import apertium
tagger = apertium.Tagger('eng')
tagger.tag('cats')
```
```
[cats/cat<n><pl>]
```

Method 2: Calling `tag()` directly.
```python
import apertium
apertium.tag('en', 'cats')
```
```
[cats/cat<n><pl>]
```

### Translation

Method 1:  Create a `Translator` object and call its `translate` method.
```python
import apertium
t = apertium.Translator('eng', 'spa')
t.translate('cats')
```
```
'Gatos'
```

Method 2: Calling `translate()` directly.
```python
import apertium
apertium.translate('en', 'spa', 'cats')
```
```
'Gatos'
```

### Installing more modes from other language data

One can also install modes by providing the path to the `lang-data`:

```python
import apertium
apertium.append_pair_path('..')
```
