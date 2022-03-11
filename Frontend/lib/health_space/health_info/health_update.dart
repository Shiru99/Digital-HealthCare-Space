class HealthUpdate {
  final String status;
  final int heartAttackChance;

  HealthUpdate.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        heartAttackChance = json['heartAttackChance'];

  Map<String, dynamic> toJson() => {
        'status': status,
        'heartAttackChance': heartAttackChance
    };
}
