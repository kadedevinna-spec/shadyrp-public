# blacksmith_hotfix

Temporary diagnostic/resource bridge for Mosquito blacksmith forge items on the RSG/v-inventory stack.

## Install

1. Upload this folder to `resources/[standalone]/blacksmith_hotfix`.
2. Add this after `ensure vorp_inventory` in `server.cfg`:

```cfg
ensure blacksmith_hotfix
```

3. Restart the server or run:

```text
ensure blacksmith_hotfix
```

## Test Commands

In game:

```text
/bsseeditems
/bsdebuginv
/bscheckbridge
/bsgiveforge
/placeforge 1
```

From server console:

```text
bsseeditems
bsdebuginv <playerId>
bscheckbridge
bsgiveforge <playerId> blacksmith_forge 1
```
