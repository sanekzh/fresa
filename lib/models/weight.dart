class Weight {
  int id;
  String weigthText;

  Weight(this.id, this.weigthText);

  static List<Weight> getWeight() {
    return <Weight>[
      Weight(1, '0,2 кг'),
      Weight(2, '0,3 кг'),
      Weight(3, '0,4 кг'),
      Weight(4, '0,5 кг'),
      Weight(5, '0,6 кг'),
      Weight(6, '0,7 кг'),
      Weight(7, '0,8 кг'),
      Weight(8, '0,9 кг'),
      Weight(9, '1,0 кг'),
      Weight(10, '1,1 кг'),
      Weight(11, '1,2 кг'),
      Weight(12, '1,3 кг'),
      Weight(13, '1,4 кг'),
      Weight(14, '1,5 кг'),

    ];
  }
}