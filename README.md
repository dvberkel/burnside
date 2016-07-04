# Burnside
Counting with [Burnsides Lemma][burnside].

## Session
We our going to color the vertices of a cube. Lets use two colors, black or
white. We need a permutation representation of the cube that acts on the
vertices.

```gap
cube := Group([(1, 2, 3, 4)(5, 6, 7, 8), (1, 4, 8, 5)(2, 3, 7, 6)]);
```

How do we know this is a correct. It certainly is a subgroup. By the
[Orbit-Stabilizer theorem][group-action] we can figure out that the order
should be `24`. 

```gap
Order(cube);
```

One way we could represent a coloring of the vertices of the cube by black and
white is as a subset of the set `\{1, 2, 3, 4, 5, 6, 7, 8\}`. E.g. the subset
\{1, 2, 3, 4\} indicates that the vertices in the top face are colored white,
while all the rest are colored black.

The [power set][power-set] of a set `S` is the set of all subsets of `S`. We can
calculate it with the `Combinations` command.

```gap
colorings := Combinations([1, 2, 3, 4, 5, 6, 7, 8]);
```

Because each vertex has two choices we expect `2^8 = 256` colorings.

```gap
Size(colorings);
```

Two colorings are the same if we can obtain one from the other by a rotation of
the cube. The `cube` group induces an action on the colorings, and two colorings
are the same precisely when they are in the same orbit.

Knowing the number of orbits this actions has is knowing the number of different
colorings. Because the group and the G-set are both small, we can calculate it
directly.

```gap
orbits := Orbits(cube, colorings, OnSets);
Size(orbits);
```

This tells us that there are `23` different black and white colorings of the
vertices of a cube.

[burnside]: https://en.wikipedia.org/wiki/Burnside's_lemma
[group-action]: https://en.wikipedia.org/wiki/Group_action
[power-set]: https://en.wikipedia.org/wiki/Power_set 
