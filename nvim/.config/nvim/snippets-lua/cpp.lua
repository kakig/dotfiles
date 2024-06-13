local M = {
  s({trig="cph", name="cph"}, {
    t({
      "#include <bits/stdc++.h>",
      "",
      "#define llu long long unsigned int",
      "#define ll long long int",
      "",
      "using namespace std;",
      "",
      "void solve() {",
      "  ",
    }),
    i(0),
    t({
      "",
      "}",
    }),
    t({
      "",
      "",
      "int main() {",
      "  std::ios_base::sync_with_stdio(false);",
      "  int t = 1;",
      "  //std::cin >> t;",
      "  while (t--) {",
      "    solve();",
      "  }",
      "  return 0;",
      "}",
    }),
  })
}

return M
