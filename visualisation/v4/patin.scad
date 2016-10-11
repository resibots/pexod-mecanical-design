$fn=100;

patin();

module patin() {
  /* Diameter of the round part on the part's top */
  diametre_cercle = 6.5;

  rotate_extrude(angle=360) {
    polygon([
      [30/2, 0],
      [27/2, 18-diametre_cercle/2],
      [27/2-diametre_cercle, 18-diametre_cercle/2],
      [12.5/2, 8.4],
      [4.65/2, 8.4],
      [4.65/2, 0]
      ]);
    translate([27/2-diametre_cercle/2, 18-diametre_cercle/2])
      circle(d=diametre_cercle);
  }
}