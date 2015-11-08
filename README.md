# Idn

LibIdn crystal binding.

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  idn:
    github: kostya/idn
```


## Usage


```crystal
require "idn"

p Idn.to_ascii "топ-site.рф"
# "xn---site-iyehw.xn--p1ai"

p Idn.to_unicode "xn---site-iyehw.xn--p1ai"
# "топ-site.рф"
```
