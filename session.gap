cube := Group([(1, 2, 3, 4)(5, 6, 7, 8), (1, 4, 8, 5)(2, 3, 7, 6)]);

Order(cube);

degree := 8;
colorings := Filtered(
  Combinations(Cartesian([1..degree], ["b","w"]), degree)
, \c -> Size(Set(List(c, \a -> a[1]))) = degree
);

Size(colorings);

OnFunctions := function(omega, g)
  local result;
  result := List(omega, t -> [t[1]^g, t[2]]);
  SortBy(result, t -> t[1]);
  return result;
end;

orbits := Orbits(cube, colorings, OnFunctions);
Size(orbits);

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

IsFixed := function(omega, g)
    return OnFunctions(omega, g) = omega;
end;

fixed := Filtered(colorings, \c -> IsFixed(c, cube.1));

orbitCount := 1/Order(cube) * Sum(
  List(Elements(cube), \g -> Size(Filtered(colorings, \c -> IsFixed(c, g))))
);
