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
white is as a function from the set `{1, 2, 3, 4, 5, 6, 7, 8}` to the set
`{"b", "w"}`. Functions are represented as special subsets of the Cartesian
product of the two sets. E.g. the function
`{(1,"w"), (2,"w"), (3,"w"), (4,"w"), (5,"b"), (6,"b"), (7,"b"), (8,"b")}`
indicates that the vertices in the top face are colored white, while all the
rest are colored black. We can calculate it with the following combination of
functions. 

```gap
degree := 8;
colorings := Filtered(
  Combinations(Cartesian([1..degree], ["b","w"]), degree)
, \c -> Size(Set(List(c, \a -> a[1]))) = degree
);
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

For this we need to tell GAP how to compute the action. We will define the
`OnFunctions` function for this

```gap
OnFunctions := function(omega, g)
  local result;
  result := List(omega, t -> [t[1]^g, t[2]]);
  SortBy(result, t -> t[1]);
  return result;
end;
```

with this we find

```gap
orbits := Orbits(cube, colorings, OnFunctions);
Size(orbits);
```

This tells us that there are `23` different black and white colorings of the
vertices of a cube.

We want to reproduce this result by using Burnside's lemma. For this we need to
figure out the image of a coloring under a group element. This is achieved with
the `OnSets` acting function.

```gap
image := OnFunctions([
    [1, "w"],
    [2, "w"],
    [3, "w"],
    [4, "b"],
    [5, "b"],
    [6, "b"],
    [7, "b"],
    [8, "b"],
], cube.1);
```

Burnside's lemma equates the number of orbits with the average number of
colorings fixed by a permutation. Let's create a function for that

```gap
IsFixed := function(omega, g)
    return OnFunctions(omega, g) = omega;
end;
```

We can use `IsFixed` to filter all the colorings that are fixed by a
permutation.

```gap
fixed := Filtered(colorings, \c -> IsFixed(c, cube.1));
```

We need the size of these fixed colorings and sum them for each permutation in
the group. This sum should be averaged with the group order.

```gap
orbitCount := 1/Order(cube) * Sum(List(Elements(cube), \g -> Size(Filtered(colorings, \c -> IsFixed(c, g)))));
```

This answer agrees with the direct calculation.

[burnside]: https://en.wikipedia.org/wiki/Burnside's_lemma
[group-action]: https://en.wikipedia.org/wiki/Group_action
[power-set]: https://en.wikipedia.org/wiki/Power_set 
