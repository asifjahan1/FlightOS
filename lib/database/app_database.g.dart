// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AirportTableTable extends AirportTable
    with TableInfo<$AirportTableTable, AirportEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AirportTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _icaoCodeMeta = const VerificationMeta(
    'icaoCode',
  );
  @override
  late final GeneratedColumn<String> icaoCode = GeneratedColumn<String>(
    'icao_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _faaCodeMeta = const VerificationMeta(
    'faaCode',
  );
  @override
  late final GeneratedColumn<String> faaCode = GeneratedColumn<String>(
    'faa_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iataCodeMeta = const VerificationMeta(
    'iataCode',
  );
  @override
  late final GeneratedColumn<String> iataCode = GeneratedColumn<String>(
    'iata_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _elevationFtMeta = const VerificationMeta(
    'elevationFt',
  );
  @override
  late final GeneratedColumn<double> elevationFt = GeneratedColumn<double>(
    'elevation_ft',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countryCodeMeta = const VerificationMeta(
    'countryCode',
  );
  @override
  late final GeneratedColumn<String> countryCode = GeneratedColumn<String>(
    'country_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _regionCodeMeta = const VerificationMeta(
    'regionCode',
  );
  @override
  late final GeneratedColumn<String> regionCode = GeneratedColumn<String>(
    'region_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _municipalityMeta = const VerificationMeta(
    'municipality',
  );
  @override
  late final GeneratedColumn<String> municipality = GeneratedColumn<String>(
    'municipality',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timezoneMeta = const VerificationMeta(
    'timezone',
  );
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
    'timezone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hasTowerMeta = const VerificationMeta(
    'hasTower',
  );
  @override
  late final GeneratedColumn<bool> hasTower = GeneratedColumn<bool>(
    'has_tower',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_tower" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _magneticVariationMeta = const VerificationMeta(
    'magneticVariation',
  );
  @override
  late final GeneratedColumn<double> magneticVariation =
      GeneratedColumn<double>(
        'magnetic_variation',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _dataSourceMeta = const VerificationMeta(
    'dataSource',
  );
  @override
  late final GeneratedColumn<String> dataSource = GeneratedColumn<String>(
    'data_source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _airacCycleMeta = const VerificationMeta(
    'airacCycle',
  );
  @override
  late final GeneratedColumn<String> airacCycle = GeneratedColumn<String>(
    'airac_cycle',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    icaoCode,
    faaCode,
    iataCode,
    name,
    type,
    latitude,
    longitude,
    elevationFt,
    countryCode,
    regionCode,
    municipality,
    timezone,
    hasTower,
    magneticVariation,
    dataSource,
    airacCycle,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'airports';
  @override
  VerificationContext validateIntegrity(
    Insertable<AirportEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('icao_code')) {
      context.handle(
        _icaoCodeMeta,
        icaoCode.isAcceptableOrUnknown(data['icao_code']!, _icaoCodeMeta),
      );
    }
    if (data.containsKey('faa_code')) {
      context.handle(
        _faaCodeMeta,
        faaCode.isAcceptableOrUnknown(data['faa_code']!, _faaCodeMeta),
      );
    }
    if (data.containsKey('iata_code')) {
      context.handle(
        _iataCodeMeta,
        iataCode.isAcceptableOrUnknown(data['iata_code']!, _iataCodeMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('elevation_ft')) {
      context.handle(
        _elevationFtMeta,
        elevationFt.isAcceptableOrUnknown(
          data['elevation_ft']!,
          _elevationFtMeta,
        ),
      );
    }
    if (data.containsKey('country_code')) {
      context.handle(
        _countryCodeMeta,
        countryCode.isAcceptableOrUnknown(
          data['country_code']!,
          _countryCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_countryCodeMeta);
    }
    if (data.containsKey('region_code')) {
      context.handle(
        _regionCodeMeta,
        regionCode.isAcceptableOrUnknown(data['region_code']!, _regionCodeMeta),
      );
    }
    if (data.containsKey('municipality')) {
      context.handle(
        _municipalityMeta,
        municipality.isAcceptableOrUnknown(
          data['municipality']!,
          _municipalityMeta,
        ),
      );
    }
    if (data.containsKey('timezone')) {
      context.handle(
        _timezoneMeta,
        timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta),
      );
    }
    if (data.containsKey('has_tower')) {
      context.handle(
        _hasTowerMeta,
        hasTower.isAcceptableOrUnknown(data['has_tower']!, _hasTowerMeta),
      );
    }
    if (data.containsKey('magnetic_variation')) {
      context.handle(
        _magneticVariationMeta,
        magneticVariation.isAcceptableOrUnknown(
          data['magnetic_variation']!,
          _magneticVariationMeta,
        ),
      );
    }
    if (data.containsKey('data_source')) {
      context.handle(
        _dataSourceMeta,
        dataSource.isAcceptableOrUnknown(data['data_source']!, _dataSourceMeta),
      );
    } else if (isInserting) {
      context.missing(_dataSourceMeta);
    }
    if (data.containsKey('airac_cycle')) {
      context.handle(
        _airacCycleMeta,
        airacCycle.isAcceptableOrUnknown(data['airac_cycle']!, _airacCycleMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AirportEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AirportEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      icaoCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icao_code'],
      ),
      faaCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}faa_code'],
      ),
      iataCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}iata_code'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      elevationFt: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}elevation_ft'],
      ),
      countryCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country_code'],
      )!,
      regionCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region_code'],
      ),
      municipality: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}municipality'],
      ),
      timezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone'],
      ),
      hasTower: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_tower'],
      )!,
      magneticVariation: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}magnetic_variation'],
      ),
      dataSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}data_source'],
      )!,
      airacCycle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}airac_cycle'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AirportTableTable createAlias(String alias) {
    return $AirportTableTable(attachedDatabase, alias);
  }
}

class AirportEntry extends DataClass implements Insertable<AirportEntry> {
  final int id;
  final String? icaoCode;
  final String? faaCode;
  final String? iataCode;
  final String name;
  final String type;
  final double latitude;
  final double longitude;
  final double? elevationFt;
  final String countryCode;
  final String? regionCode;
  final String? municipality;
  final String? timezone;
  final bool hasTower;
  final double? magneticVariation;
  final String dataSource;
  final String? airacCycle;
  final DateTime updatedAt;
  const AirportEntry({
    required this.id,
    this.icaoCode,
    this.faaCode,
    this.iataCode,
    required this.name,
    required this.type,
    required this.latitude,
    required this.longitude,
    this.elevationFt,
    required this.countryCode,
    this.regionCode,
    this.municipality,
    this.timezone,
    required this.hasTower,
    this.magneticVariation,
    required this.dataSource,
    this.airacCycle,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || icaoCode != null) {
      map['icao_code'] = Variable<String>(icaoCode);
    }
    if (!nullToAbsent || faaCode != null) {
      map['faa_code'] = Variable<String>(faaCode);
    }
    if (!nullToAbsent || iataCode != null) {
      map['iata_code'] = Variable<String>(iataCode);
    }
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    if (!nullToAbsent || elevationFt != null) {
      map['elevation_ft'] = Variable<double>(elevationFt);
    }
    map['country_code'] = Variable<String>(countryCode);
    if (!nullToAbsent || regionCode != null) {
      map['region_code'] = Variable<String>(regionCode);
    }
    if (!nullToAbsent || municipality != null) {
      map['municipality'] = Variable<String>(municipality);
    }
    if (!nullToAbsent || timezone != null) {
      map['timezone'] = Variable<String>(timezone);
    }
    map['has_tower'] = Variable<bool>(hasTower);
    if (!nullToAbsent || magneticVariation != null) {
      map['magnetic_variation'] = Variable<double>(magneticVariation);
    }
    map['data_source'] = Variable<String>(dataSource);
    if (!nullToAbsent || airacCycle != null) {
      map['airac_cycle'] = Variable<String>(airacCycle);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AirportTableCompanion toCompanion(bool nullToAbsent) {
    return AirportTableCompanion(
      id: Value(id),
      icaoCode: icaoCode == null && nullToAbsent
          ? const Value.absent()
          : Value(icaoCode),
      faaCode: faaCode == null && nullToAbsent
          ? const Value.absent()
          : Value(faaCode),
      iataCode: iataCode == null && nullToAbsent
          ? const Value.absent()
          : Value(iataCode),
      name: Value(name),
      type: Value(type),
      latitude: Value(latitude),
      longitude: Value(longitude),
      elevationFt: elevationFt == null && nullToAbsent
          ? const Value.absent()
          : Value(elevationFt),
      countryCode: Value(countryCode),
      regionCode: regionCode == null && nullToAbsent
          ? const Value.absent()
          : Value(regionCode),
      municipality: municipality == null && nullToAbsent
          ? const Value.absent()
          : Value(municipality),
      timezone: timezone == null && nullToAbsent
          ? const Value.absent()
          : Value(timezone),
      hasTower: Value(hasTower),
      magneticVariation: magneticVariation == null && nullToAbsent
          ? const Value.absent()
          : Value(magneticVariation),
      dataSource: Value(dataSource),
      airacCycle: airacCycle == null && nullToAbsent
          ? const Value.absent()
          : Value(airacCycle),
      updatedAt: Value(updatedAt),
    );
  }

  factory AirportEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AirportEntry(
      id: serializer.fromJson<int>(json['id']),
      icaoCode: serializer.fromJson<String?>(json['icaoCode']),
      faaCode: serializer.fromJson<String?>(json['faaCode']),
      iataCode: serializer.fromJson<String?>(json['iataCode']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      elevationFt: serializer.fromJson<double?>(json['elevationFt']),
      countryCode: serializer.fromJson<String>(json['countryCode']),
      regionCode: serializer.fromJson<String?>(json['regionCode']),
      municipality: serializer.fromJson<String?>(json['municipality']),
      timezone: serializer.fromJson<String?>(json['timezone']),
      hasTower: serializer.fromJson<bool>(json['hasTower']),
      magneticVariation: serializer.fromJson<double?>(
        json['magneticVariation'],
      ),
      dataSource: serializer.fromJson<String>(json['dataSource']),
      airacCycle: serializer.fromJson<String?>(json['airacCycle']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'icaoCode': serializer.toJson<String?>(icaoCode),
      'faaCode': serializer.toJson<String?>(faaCode),
      'iataCode': serializer.toJson<String?>(iataCode),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'elevationFt': serializer.toJson<double?>(elevationFt),
      'countryCode': serializer.toJson<String>(countryCode),
      'regionCode': serializer.toJson<String?>(regionCode),
      'municipality': serializer.toJson<String?>(municipality),
      'timezone': serializer.toJson<String?>(timezone),
      'hasTower': serializer.toJson<bool>(hasTower),
      'magneticVariation': serializer.toJson<double?>(magneticVariation),
      'dataSource': serializer.toJson<String>(dataSource),
      'airacCycle': serializer.toJson<String?>(airacCycle),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AirportEntry copyWith({
    int? id,
    Value<String?> icaoCode = const Value.absent(),
    Value<String?> faaCode = const Value.absent(),
    Value<String?> iataCode = const Value.absent(),
    String? name,
    String? type,
    double? latitude,
    double? longitude,
    Value<double?> elevationFt = const Value.absent(),
    String? countryCode,
    Value<String?> regionCode = const Value.absent(),
    Value<String?> municipality = const Value.absent(),
    Value<String?> timezone = const Value.absent(),
    bool? hasTower,
    Value<double?> magneticVariation = const Value.absent(),
    String? dataSource,
    Value<String?> airacCycle = const Value.absent(),
    DateTime? updatedAt,
  }) => AirportEntry(
    id: id ?? this.id,
    icaoCode: icaoCode.present ? icaoCode.value : this.icaoCode,
    faaCode: faaCode.present ? faaCode.value : this.faaCode,
    iataCode: iataCode.present ? iataCode.value : this.iataCode,
    name: name ?? this.name,
    type: type ?? this.type,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    elevationFt: elevationFt.present ? elevationFt.value : this.elevationFt,
    countryCode: countryCode ?? this.countryCode,
    regionCode: regionCode.present ? regionCode.value : this.regionCode,
    municipality: municipality.present ? municipality.value : this.municipality,
    timezone: timezone.present ? timezone.value : this.timezone,
    hasTower: hasTower ?? this.hasTower,
    magneticVariation: magneticVariation.present
        ? magneticVariation.value
        : this.magneticVariation,
    dataSource: dataSource ?? this.dataSource,
    airacCycle: airacCycle.present ? airacCycle.value : this.airacCycle,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AirportEntry copyWithCompanion(AirportTableCompanion data) {
    return AirportEntry(
      id: data.id.present ? data.id.value : this.id,
      icaoCode: data.icaoCode.present ? data.icaoCode.value : this.icaoCode,
      faaCode: data.faaCode.present ? data.faaCode.value : this.faaCode,
      iataCode: data.iataCode.present ? data.iataCode.value : this.iataCode,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      elevationFt: data.elevationFt.present
          ? data.elevationFt.value
          : this.elevationFt,
      countryCode: data.countryCode.present
          ? data.countryCode.value
          : this.countryCode,
      regionCode: data.regionCode.present
          ? data.regionCode.value
          : this.regionCode,
      municipality: data.municipality.present
          ? data.municipality.value
          : this.municipality,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      hasTower: data.hasTower.present ? data.hasTower.value : this.hasTower,
      magneticVariation: data.magneticVariation.present
          ? data.magneticVariation.value
          : this.magneticVariation,
      dataSource: data.dataSource.present
          ? data.dataSource.value
          : this.dataSource,
      airacCycle: data.airacCycle.present
          ? data.airacCycle.value
          : this.airacCycle,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AirportEntry(')
          ..write('id: $id, ')
          ..write('icaoCode: $icaoCode, ')
          ..write('faaCode: $faaCode, ')
          ..write('iataCode: $iataCode, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('elevationFt: $elevationFt, ')
          ..write('countryCode: $countryCode, ')
          ..write('regionCode: $regionCode, ')
          ..write('municipality: $municipality, ')
          ..write('timezone: $timezone, ')
          ..write('hasTower: $hasTower, ')
          ..write('magneticVariation: $magneticVariation, ')
          ..write('dataSource: $dataSource, ')
          ..write('airacCycle: $airacCycle, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    icaoCode,
    faaCode,
    iataCode,
    name,
    type,
    latitude,
    longitude,
    elevationFt,
    countryCode,
    regionCode,
    municipality,
    timezone,
    hasTower,
    magneticVariation,
    dataSource,
    airacCycle,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AirportEntry &&
          other.id == this.id &&
          other.icaoCode == this.icaoCode &&
          other.faaCode == this.faaCode &&
          other.iataCode == this.iataCode &&
          other.name == this.name &&
          other.type == this.type &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.elevationFt == this.elevationFt &&
          other.countryCode == this.countryCode &&
          other.regionCode == this.regionCode &&
          other.municipality == this.municipality &&
          other.timezone == this.timezone &&
          other.hasTower == this.hasTower &&
          other.magneticVariation == this.magneticVariation &&
          other.dataSource == this.dataSource &&
          other.airacCycle == this.airacCycle &&
          other.updatedAt == this.updatedAt);
}

class AirportTableCompanion extends UpdateCompanion<AirportEntry> {
  final Value<int> id;
  final Value<String?> icaoCode;
  final Value<String?> faaCode;
  final Value<String?> iataCode;
  final Value<String> name;
  final Value<String> type;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<double?> elevationFt;
  final Value<String> countryCode;
  final Value<String?> regionCode;
  final Value<String?> municipality;
  final Value<String?> timezone;
  final Value<bool> hasTower;
  final Value<double?> magneticVariation;
  final Value<String> dataSource;
  final Value<String?> airacCycle;
  final Value<DateTime> updatedAt;
  const AirportTableCompanion({
    this.id = const Value.absent(),
    this.icaoCode = const Value.absent(),
    this.faaCode = const Value.absent(),
    this.iataCode = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.elevationFt = const Value.absent(),
    this.countryCode = const Value.absent(),
    this.regionCode = const Value.absent(),
    this.municipality = const Value.absent(),
    this.timezone = const Value.absent(),
    this.hasTower = const Value.absent(),
    this.magneticVariation = const Value.absent(),
    this.dataSource = const Value.absent(),
    this.airacCycle = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AirportTableCompanion.insert({
    this.id = const Value.absent(),
    this.icaoCode = const Value.absent(),
    this.faaCode = const Value.absent(),
    this.iataCode = const Value.absent(),
    required String name,
    required String type,
    required double latitude,
    required double longitude,
    this.elevationFt = const Value.absent(),
    required String countryCode,
    this.regionCode = const Value.absent(),
    this.municipality = const Value.absent(),
    this.timezone = const Value.absent(),
    this.hasTower = const Value.absent(),
    this.magneticVariation = const Value.absent(),
    required String dataSource,
    this.airacCycle = const Value.absent(),
    required DateTime updatedAt,
  }) : name = Value(name),
       type = Value(type),
       latitude = Value(latitude),
       longitude = Value(longitude),
       countryCode = Value(countryCode),
       dataSource = Value(dataSource),
       updatedAt = Value(updatedAt);
  static Insertable<AirportEntry> custom({
    Expression<int>? id,
    Expression<String>? icaoCode,
    Expression<String>? faaCode,
    Expression<String>? iataCode,
    Expression<String>? name,
    Expression<String>? type,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? elevationFt,
    Expression<String>? countryCode,
    Expression<String>? regionCode,
    Expression<String>? municipality,
    Expression<String>? timezone,
    Expression<bool>? hasTower,
    Expression<double>? magneticVariation,
    Expression<String>? dataSource,
    Expression<String>? airacCycle,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (icaoCode != null) 'icao_code': icaoCode,
      if (faaCode != null) 'faa_code': faaCode,
      if (iataCode != null) 'iata_code': iataCode,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (elevationFt != null) 'elevation_ft': elevationFt,
      if (countryCode != null) 'country_code': countryCode,
      if (regionCode != null) 'region_code': regionCode,
      if (municipality != null) 'municipality': municipality,
      if (timezone != null) 'timezone': timezone,
      if (hasTower != null) 'has_tower': hasTower,
      if (magneticVariation != null) 'magnetic_variation': magneticVariation,
      if (dataSource != null) 'data_source': dataSource,
      if (airacCycle != null) 'airac_cycle': airacCycle,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AirportTableCompanion copyWith({
    Value<int>? id,
    Value<String?>? icaoCode,
    Value<String?>? faaCode,
    Value<String?>? iataCode,
    Value<String>? name,
    Value<String>? type,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<double?>? elevationFt,
    Value<String>? countryCode,
    Value<String?>? regionCode,
    Value<String?>? municipality,
    Value<String?>? timezone,
    Value<bool>? hasTower,
    Value<double?>? magneticVariation,
    Value<String>? dataSource,
    Value<String?>? airacCycle,
    Value<DateTime>? updatedAt,
  }) {
    return AirportTableCompanion(
      id: id ?? this.id,
      icaoCode: icaoCode ?? this.icaoCode,
      faaCode: faaCode ?? this.faaCode,
      iataCode: iataCode ?? this.iataCode,
      name: name ?? this.name,
      type: type ?? this.type,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      elevationFt: elevationFt ?? this.elevationFt,
      countryCode: countryCode ?? this.countryCode,
      regionCode: regionCode ?? this.regionCode,
      municipality: municipality ?? this.municipality,
      timezone: timezone ?? this.timezone,
      hasTower: hasTower ?? this.hasTower,
      magneticVariation: magneticVariation ?? this.magneticVariation,
      dataSource: dataSource ?? this.dataSource,
      airacCycle: airacCycle ?? this.airacCycle,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (icaoCode.present) {
      map['icao_code'] = Variable<String>(icaoCode.value);
    }
    if (faaCode.present) {
      map['faa_code'] = Variable<String>(faaCode.value);
    }
    if (iataCode.present) {
      map['iata_code'] = Variable<String>(iataCode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (elevationFt.present) {
      map['elevation_ft'] = Variable<double>(elevationFt.value);
    }
    if (countryCode.present) {
      map['country_code'] = Variable<String>(countryCode.value);
    }
    if (regionCode.present) {
      map['region_code'] = Variable<String>(regionCode.value);
    }
    if (municipality.present) {
      map['municipality'] = Variable<String>(municipality.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (hasTower.present) {
      map['has_tower'] = Variable<bool>(hasTower.value);
    }
    if (magneticVariation.present) {
      map['magnetic_variation'] = Variable<double>(magneticVariation.value);
    }
    if (dataSource.present) {
      map['data_source'] = Variable<String>(dataSource.value);
    }
    if (airacCycle.present) {
      map['airac_cycle'] = Variable<String>(airacCycle.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AirportTableCompanion(')
          ..write('id: $id, ')
          ..write('icaoCode: $icaoCode, ')
          ..write('faaCode: $faaCode, ')
          ..write('iataCode: $iataCode, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('elevationFt: $elevationFt, ')
          ..write('countryCode: $countryCode, ')
          ..write('regionCode: $regionCode, ')
          ..write('municipality: $municipality, ')
          ..write('timezone: $timezone, ')
          ..write('hasTower: $hasTower, ')
          ..write('magneticVariation: $magneticVariation, ')
          ..write('dataSource: $dataSource, ')
          ..write('airacCycle: $airacCycle, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RunwayTableTable extends RunwayTable
    with TableInfo<$RunwayTableTable, RunwayEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RunwayTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _airportIdMeta = const VerificationMeta(
    'airportId',
  );
  @override
  late final GeneratedColumn<int> airportId = GeneratedColumn<int>(
    'airport_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _designatorMeta = const VerificationMeta(
    'designator',
  );
  @override
  late final GeneratedColumn<String> designator = GeneratedColumn<String>(
    'designator',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lengthFtMeta = const VerificationMeta(
    'lengthFt',
  );
  @override
  late final GeneratedColumn<double> lengthFt = GeneratedColumn<double>(
    'length_ft',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _widthFtMeta = const VerificationMeta(
    'widthFt',
  );
  @override
  late final GeneratedColumn<double> widthFt = GeneratedColumn<double>(
    'width_ft',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _surfaceMeta = const VerificationMeta(
    'surface',
  );
  @override
  late final GeneratedColumn<String> surface = GeneratedColumn<String>(
    'surface',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lightedMeta = const VerificationMeta(
    'lighted',
  );
  @override
  late final GeneratedColumn<bool> lighted = GeneratedColumn<bool>(
    'lighted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("lighted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _closedMeta = const VerificationMeta('closed');
  @override
  late final GeneratedColumn<bool> closed = GeneratedColumn<bool>(
    'closed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("closed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _heDesignatorMeta = const VerificationMeta(
    'heDesignator',
  );
  @override
  late final GeneratedColumn<String> heDesignator = GeneratedColumn<String>(
    'he_designator',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heLatitudeMeta = const VerificationMeta(
    'heLatitude',
  );
  @override
  late final GeneratedColumn<double> heLatitude = GeneratedColumn<double>(
    'he_latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heLongitudeMeta = const VerificationMeta(
    'heLongitude',
  );
  @override
  late final GeneratedColumn<double> heLongitude = GeneratedColumn<double>(
    'he_longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heElevationFtMeta = const VerificationMeta(
    'heElevationFt',
  );
  @override
  late final GeneratedColumn<double> heElevationFt = GeneratedColumn<double>(
    'he_elevation_ft',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heHeadingTrueMeta = const VerificationMeta(
    'heHeadingTrue',
  );
  @override
  late final GeneratedColumn<double> heHeadingTrue = GeneratedColumn<double>(
    'he_heading_true',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _leDesignatorMeta = const VerificationMeta(
    'leDesignator',
  );
  @override
  late final GeneratedColumn<String> leDesignator = GeneratedColumn<String>(
    'le_designator',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _leLatitudeMeta = const VerificationMeta(
    'leLatitude',
  );
  @override
  late final GeneratedColumn<double> leLatitude = GeneratedColumn<double>(
    'le_latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _leLongitudeMeta = const VerificationMeta(
    'leLongitude',
  );
  @override
  late final GeneratedColumn<double> leLongitude = GeneratedColumn<double>(
    'le_longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _leElevationFtMeta = const VerificationMeta(
    'leElevationFt',
  );
  @override
  late final GeneratedColumn<double> leElevationFt = GeneratedColumn<double>(
    'le_elevation_ft',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _leHeadingTrueMeta = const VerificationMeta(
    'leHeadingTrue',
  );
  @override
  late final GeneratedColumn<double> leHeadingTrue = GeneratedColumn<double>(
    'le_heading_true',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    airportId,
    designator,
    lengthFt,
    widthFt,
    surface,
    lighted,
    closed,
    heDesignator,
    heLatitude,
    heLongitude,
    heElevationFt,
    heHeadingTrue,
    leDesignator,
    leLatitude,
    leLongitude,
    leElevationFt,
    leHeadingTrue,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'runways';
  @override
  VerificationContext validateIntegrity(
    Insertable<RunwayEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('airport_id')) {
      context.handle(
        _airportIdMeta,
        airportId.isAcceptableOrUnknown(data['airport_id']!, _airportIdMeta),
      );
    } else if (isInserting) {
      context.missing(_airportIdMeta);
    }
    if (data.containsKey('designator')) {
      context.handle(
        _designatorMeta,
        designator.isAcceptableOrUnknown(data['designator']!, _designatorMeta),
      );
    } else if (isInserting) {
      context.missing(_designatorMeta);
    }
    if (data.containsKey('length_ft')) {
      context.handle(
        _lengthFtMeta,
        lengthFt.isAcceptableOrUnknown(data['length_ft']!, _lengthFtMeta),
      );
    }
    if (data.containsKey('width_ft')) {
      context.handle(
        _widthFtMeta,
        widthFt.isAcceptableOrUnknown(data['width_ft']!, _widthFtMeta),
      );
    }
    if (data.containsKey('surface')) {
      context.handle(
        _surfaceMeta,
        surface.isAcceptableOrUnknown(data['surface']!, _surfaceMeta),
      );
    }
    if (data.containsKey('lighted')) {
      context.handle(
        _lightedMeta,
        lighted.isAcceptableOrUnknown(data['lighted']!, _lightedMeta),
      );
    }
    if (data.containsKey('closed')) {
      context.handle(
        _closedMeta,
        closed.isAcceptableOrUnknown(data['closed']!, _closedMeta),
      );
    }
    if (data.containsKey('he_designator')) {
      context.handle(
        _heDesignatorMeta,
        heDesignator.isAcceptableOrUnknown(
          data['he_designator']!,
          _heDesignatorMeta,
        ),
      );
    }
    if (data.containsKey('he_latitude')) {
      context.handle(
        _heLatitudeMeta,
        heLatitude.isAcceptableOrUnknown(data['he_latitude']!, _heLatitudeMeta),
      );
    }
    if (data.containsKey('he_longitude')) {
      context.handle(
        _heLongitudeMeta,
        heLongitude.isAcceptableOrUnknown(
          data['he_longitude']!,
          _heLongitudeMeta,
        ),
      );
    }
    if (data.containsKey('he_elevation_ft')) {
      context.handle(
        _heElevationFtMeta,
        heElevationFt.isAcceptableOrUnknown(
          data['he_elevation_ft']!,
          _heElevationFtMeta,
        ),
      );
    }
    if (data.containsKey('he_heading_true')) {
      context.handle(
        _heHeadingTrueMeta,
        heHeadingTrue.isAcceptableOrUnknown(
          data['he_heading_true']!,
          _heHeadingTrueMeta,
        ),
      );
    }
    if (data.containsKey('le_designator')) {
      context.handle(
        _leDesignatorMeta,
        leDesignator.isAcceptableOrUnknown(
          data['le_designator']!,
          _leDesignatorMeta,
        ),
      );
    }
    if (data.containsKey('le_latitude')) {
      context.handle(
        _leLatitudeMeta,
        leLatitude.isAcceptableOrUnknown(data['le_latitude']!, _leLatitudeMeta),
      );
    }
    if (data.containsKey('le_longitude')) {
      context.handle(
        _leLongitudeMeta,
        leLongitude.isAcceptableOrUnknown(
          data['le_longitude']!,
          _leLongitudeMeta,
        ),
      );
    }
    if (data.containsKey('le_elevation_ft')) {
      context.handle(
        _leElevationFtMeta,
        leElevationFt.isAcceptableOrUnknown(
          data['le_elevation_ft']!,
          _leElevationFtMeta,
        ),
      );
    }
    if (data.containsKey('le_heading_true')) {
      context.handle(
        _leHeadingTrueMeta,
        leHeadingTrue.isAcceptableOrUnknown(
          data['le_heading_true']!,
          _leHeadingTrueMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RunwayEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RunwayEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      airportId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}airport_id'],
      )!,
      designator: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}designator'],
      )!,
      lengthFt: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}length_ft'],
      ),
      widthFt: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}width_ft'],
      ),
      surface: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}surface'],
      ),
      lighted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}lighted'],
      )!,
      closed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}closed'],
      )!,
      heDesignator: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}he_designator'],
      ),
      heLatitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}he_latitude'],
      ),
      heLongitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}he_longitude'],
      ),
      heElevationFt: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}he_elevation_ft'],
      ),
      heHeadingTrue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}he_heading_true'],
      ),
      leDesignator: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}le_designator'],
      ),
      leLatitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}le_latitude'],
      ),
      leLongitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}le_longitude'],
      ),
      leElevationFt: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}le_elevation_ft'],
      ),
      leHeadingTrue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}le_heading_true'],
      ),
    );
  }

  @override
  $RunwayTableTable createAlias(String alias) {
    return $RunwayTableTable(attachedDatabase, alias);
  }
}

class RunwayEntry extends DataClass implements Insertable<RunwayEntry> {
  final int id;
  final int airportId;
  final String designator;
  final double? lengthFt;
  final double? widthFt;
  final String? surface;
  final bool lighted;
  final bool closed;
  final String? heDesignator;
  final double? heLatitude;
  final double? heLongitude;
  final double? heElevationFt;
  final double? heHeadingTrue;
  final String? leDesignator;
  final double? leLatitude;
  final double? leLongitude;
  final double? leElevationFt;
  final double? leHeadingTrue;
  const RunwayEntry({
    required this.id,
    required this.airportId,
    required this.designator,
    this.lengthFt,
    this.widthFt,
    this.surface,
    required this.lighted,
    required this.closed,
    this.heDesignator,
    this.heLatitude,
    this.heLongitude,
    this.heElevationFt,
    this.heHeadingTrue,
    this.leDesignator,
    this.leLatitude,
    this.leLongitude,
    this.leElevationFt,
    this.leHeadingTrue,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['airport_id'] = Variable<int>(airportId);
    map['designator'] = Variable<String>(designator);
    if (!nullToAbsent || lengthFt != null) {
      map['length_ft'] = Variable<double>(lengthFt);
    }
    if (!nullToAbsent || widthFt != null) {
      map['width_ft'] = Variable<double>(widthFt);
    }
    if (!nullToAbsent || surface != null) {
      map['surface'] = Variable<String>(surface);
    }
    map['lighted'] = Variable<bool>(lighted);
    map['closed'] = Variable<bool>(closed);
    if (!nullToAbsent || heDesignator != null) {
      map['he_designator'] = Variable<String>(heDesignator);
    }
    if (!nullToAbsent || heLatitude != null) {
      map['he_latitude'] = Variable<double>(heLatitude);
    }
    if (!nullToAbsent || heLongitude != null) {
      map['he_longitude'] = Variable<double>(heLongitude);
    }
    if (!nullToAbsent || heElevationFt != null) {
      map['he_elevation_ft'] = Variable<double>(heElevationFt);
    }
    if (!nullToAbsent || heHeadingTrue != null) {
      map['he_heading_true'] = Variable<double>(heHeadingTrue);
    }
    if (!nullToAbsent || leDesignator != null) {
      map['le_designator'] = Variable<String>(leDesignator);
    }
    if (!nullToAbsent || leLatitude != null) {
      map['le_latitude'] = Variable<double>(leLatitude);
    }
    if (!nullToAbsent || leLongitude != null) {
      map['le_longitude'] = Variable<double>(leLongitude);
    }
    if (!nullToAbsent || leElevationFt != null) {
      map['le_elevation_ft'] = Variable<double>(leElevationFt);
    }
    if (!nullToAbsent || leHeadingTrue != null) {
      map['le_heading_true'] = Variable<double>(leHeadingTrue);
    }
    return map;
  }

  RunwayTableCompanion toCompanion(bool nullToAbsent) {
    return RunwayTableCompanion(
      id: Value(id),
      airportId: Value(airportId),
      designator: Value(designator),
      lengthFt: lengthFt == null && nullToAbsent
          ? const Value.absent()
          : Value(lengthFt),
      widthFt: widthFt == null && nullToAbsent
          ? const Value.absent()
          : Value(widthFt),
      surface: surface == null && nullToAbsent
          ? const Value.absent()
          : Value(surface),
      lighted: Value(lighted),
      closed: Value(closed),
      heDesignator: heDesignator == null && nullToAbsent
          ? const Value.absent()
          : Value(heDesignator),
      heLatitude: heLatitude == null && nullToAbsent
          ? const Value.absent()
          : Value(heLatitude),
      heLongitude: heLongitude == null && nullToAbsent
          ? const Value.absent()
          : Value(heLongitude),
      heElevationFt: heElevationFt == null && nullToAbsent
          ? const Value.absent()
          : Value(heElevationFt),
      heHeadingTrue: heHeadingTrue == null && nullToAbsent
          ? const Value.absent()
          : Value(heHeadingTrue),
      leDesignator: leDesignator == null && nullToAbsent
          ? const Value.absent()
          : Value(leDesignator),
      leLatitude: leLatitude == null && nullToAbsent
          ? const Value.absent()
          : Value(leLatitude),
      leLongitude: leLongitude == null && nullToAbsent
          ? const Value.absent()
          : Value(leLongitude),
      leElevationFt: leElevationFt == null && nullToAbsent
          ? const Value.absent()
          : Value(leElevationFt),
      leHeadingTrue: leHeadingTrue == null && nullToAbsent
          ? const Value.absent()
          : Value(leHeadingTrue),
    );
  }

  factory RunwayEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RunwayEntry(
      id: serializer.fromJson<int>(json['id']),
      airportId: serializer.fromJson<int>(json['airportId']),
      designator: serializer.fromJson<String>(json['designator']),
      lengthFt: serializer.fromJson<double?>(json['lengthFt']),
      widthFt: serializer.fromJson<double?>(json['widthFt']),
      surface: serializer.fromJson<String?>(json['surface']),
      lighted: serializer.fromJson<bool>(json['lighted']),
      closed: serializer.fromJson<bool>(json['closed']),
      heDesignator: serializer.fromJson<String?>(json['heDesignator']),
      heLatitude: serializer.fromJson<double?>(json['heLatitude']),
      heLongitude: serializer.fromJson<double?>(json['heLongitude']),
      heElevationFt: serializer.fromJson<double?>(json['heElevationFt']),
      heHeadingTrue: serializer.fromJson<double?>(json['heHeadingTrue']),
      leDesignator: serializer.fromJson<String?>(json['leDesignator']),
      leLatitude: serializer.fromJson<double?>(json['leLatitude']),
      leLongitude: serializer.fromJson<double?>(json['leLongitude']),
      leElevationFt: serializer.fromJson<double?>(json['leElevationFt']),
      leHeadingTrue: serializer.fromJson<double?>(json['leHeadingTrue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'airportId': serializer.toJson<int>(airportId),
      'designator': serializer.toJson<String>(designator),
      'lengthFt': serializer.toJson<double?>(lengthFt),
      'widthFt': serializer.toJson<double?>(widthFt),
      'surface': serializer.toJson<String?>(surface),
      'lighted': serializer.toJson<bool>(lighted),
      'closed': serializer.toJson<bool>(closed),
      'heDesignator': serializer.toJson<String?>(heDesignator),
      'heLatitude': serializer.toJson<double?>(heLatitude),
      'heLongitude': serializer.toJson<double?>(heLongitude),
      'heElevationFt': serializer.toJson<double?>(heElevationFt),
      'heHeadingTrue': serializer.toJson<double?>(heHeadingTrue),
      'leDesignator': serializer.toJson<String?>(leDesignator),
      'leLatitude': serializer.toJson<double?>(leLatitude),
      'leLongitude': serializer.toJson<double?>(leLongitude),
      'leElevationFt': serializer.toJson<double?>(leElevationFt),
      'leHeadingTrue': serializer.toJson<double?>(leHeadingTrue),
    };
  }

  RunwayEntry copyWith({
    int? id,
    int? airportId,
    String? designator,
    Value<double?> lengthFt = const Value.absent(),
    Value<double?> widthFt = const Value.absent(),
    Value<String?> surface = const Value.absent(),
    bool? lighted,
    bool? closed,
    Value<String?> heDesignator = const Value.absent(),
    Value<double?> heLatitude = const Value.absent(),
    Value<double?> heLongitude = const Value.absent(),
    Value<double?> heElevationFt = const Value.absent(),
    Value<double?> heHeadingTrue = const Value.absent(),
    Value<String?> leDesignator = const Value.absent(),
    Value<double?> leLatitude = const Value.absent(),
    Value<double?> leLongitude = const Value.absent(),
    Value<double?> leElevationFt = const Value.absent(),
    Value<double?> leHeadingTrue = const Value.absent(),
  }) => RunwayEntry(
    id: id ?? this.id,
    airportId: airportId ?? this.airportId,
    designator: designator ?? this.designator,
    lengthFt: lengthFt.present ? lengthFt.value : this.lengthFt,
    widthFt: widthFt.present ? widthFt.value : this.widthFt,
    surface: surface.present ? surface.value : this.surface,
    lighted: lighted ?? this.lighted,
    closed: closed ?? this.closed,
    heDesignator: heDesignator.present ? heDesignator.value : this.heDesignator,
    heLatitude: heLatitude.present ? heLatitude.value : this.heLatitude,
    heLongitude: heLongitude.present ? heLongitude.value : this.heLongitude,
    heElevationFt: heElevationFt.present
        ? heElevationFt.value
        : this.heElevationFt,
    heHeadingTrue: heHeadingTrue.present
        ? heHeadingTrue.value
        : this.heHeadingTrue,
    leDesignator: leDesignator.present ? leDesignator.value : this.leDesignator,
    leLatitude: leLatitude.present ? leLatitude.value : this.leLatitude,
    leLongitude: leLongitude.present ? leLongitude.value : this.leLongitude,
    leElevationFt: leElevationFt.present
        ? leElevationFt.value
        : this.leElevationFt,
    leHeadingTrue: leHeadingTrue.present
        ? leHeadingTrue.value
        : this.leHeadingTrue,
  );
  RunwayEntry copyWithCompanion(RunwayTableCompanion data) {
    return RunwayEntry(
      id: data.id.present ? data.id.value : this.id,
      airportId: data.airportId.present ? data.airportId.value : this.airportId,
      designator: data.designator.present
          ? data.designator.value
          : this.designator,
      lengthFt: data.lengthFt.present ? data.lengthFt.value : this.lengthFt,
      widthFt: data.widthFt.present ? data.widthFt.value : this.widthFt,
      surface: data.surface.present ? data.surface.value : this.surface,
      lighted: data.lighted.present ? data.lighted.value : this.lighted,
      closed: data.closed.present ? data.closed.value : this.closed,
      heDesignator: data.heDesignator.present
          ? data.heDesignator.value
          : this.heDesignator,
      heLatitude: data.heLatitude.present
          ? data.heLatitude.value
          : this.heLatitude,
      heLongitude: data.heLongitude.present
          ? data.heLongitude.value
          : this.heLongitude,
      heElevationFt: data.heElevationFt.present
          ? data.heElevationFt.value
          : this.heElevationFt,
      heHeadingTrue: data.heHeadingTrue.present
          ? data.heHeadingTrue.value
          : this.heHeadingTrue,
      leDesignator: data.leDesignator.present
          ? data.leDesignator.value
          : this.leDesignator,
      leLatitude: data.leLatitude.present
          ? data.leLatitude.value
          : this.leLatitude,
      leLongitude: data.leLongitude.present
          ? data.leLongitude.value
          : this.leLongitude,
      leElevationFt: data.leElevationFt.present
          ? data.leElevationFt.value
          : this.leElevationFt,
      leHeadingTrue: data.leHeadingTrue.present
          ? data.leHeadingTrue.value
          : this.leHeadingTrue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RunwayEntry(')
          ..write('id: $id, ')
          ..write('airportId: $airportId, ')
          ..write('designator: $designator, ')
          ..write('lengthFt: $lengthFt, ')
          ..write('widthFt: $widthFt, ')
          ..write('surface: $surface, ')
          ..write('lighted: $lighted, ')
          ..write('closed: $closed, ')
          ..write('heDesignator: $heDesignator, ')
          ..write('heLatitude: $heLatitude, ')
          ..write('heLongitude: $heLongitude, ')
          ..write('heElevationFt: $heElevationFt, ')
          ..write('heHeadingTrue: $heHeadingTrue, ')
          ..write('leDesignator: $leDesignator, ')
          ..write('leLatitude: $leLatitude, ')
          ..write('leLongitude: $leLongitude, ')
          ..write('leElevationFt: $leElevationFt, ')
          ..write('leHeadingTrue: $leHeadingTrue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    airportId,
    designator,
    lengthFt,
    widthFt,
    surface,
    lighted,
    closed,
    heDesignator,
    heLatitude,
    heLongitude,
    heElevationFt,
    heHeadingTrue,
    leDesignator,
    leLatitude,
    leLongitude,
    leElevationFt,
    leHeadingTrue,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RunwayEntry &&
          other.id == this.id &&
          other.airportId == this.airportId &&
          other.designator == this.designator &&
          other.lengthFt == this.lengthFt &&
          other.widthFt == this.widthFt &&
          other.surface == this.surface &&
          other.lighted == this.lighted &&
          other.closed == this.closed &&
          other.heDesignator == this.heDesignator &&
          other.heLatitude == this.heLatitude &&
          other.heLongitude == this.heLongitude &&
          other.heElevationFt == this.heElevationFt &&
          other.heHeadingTrue == this.heHeadingTrue &&
          other.leDesignator == this.leDesignator &&
          other.leLatitude == this.leLatitude &&
          other.leLongitude == this.leLongitude &&
          other.leElevationFt == this.leElevationFt &&
          other.leHeadingTrue == this.leHeadingTrue);
}

class RunwayTableCompanion extends UpdateCompanion<RunwayEntry> {
  final Value<int> id;
  final Value<int> airportId;
  final Value<String> designator;
  final Value<double?> lengthFt;
  final Value<double?> widthFt;
  final Value<String?> surface;
  final Value<bool> lighted;
  final Value<bool> closed;
  final Value<String?> heDesignator;
  final Value<double?> heLatitude;
  final Value<double?> heLongitude;
  final Value<double?> heElevationFt;
  final Value<double?> heHeadingTrue;
  final Value<String?> leDesignator;
  final Value<double?> leLatitude;
  final Value<double?> leLongitude;
  final Value<double?> leElevationFt;
  final Value<double?> leHeadingTrue;
  const RunwayTableCompanion({
    this.id = const Value.absent(),
    this.airportId = const Value.absent(),
    this.designator = const Value.absent(),
    this.lengthFt = const Value.absent(),
    this.widthFt = const Value.absent(),
    this.surface = const Value.absent(),
    this.lighted = const Value.absent(),
    this.closed = const Value.absent(),
    this.heDesignator = const Value.absent(),
    this.heLatitude = const Value.absent(),
    this.heLongitude = const Value.absent(),
    this.heElevationFt = const Value.absent(),
    this.heHeadingTrue = const Value.absent(),
    this.leDesignator = const Value.absent(),
    this.leLatitude = const Value.absent(),
    this.leLongitude = const Value.absent(),
    this.leElevationFt = const Value.absent(),
    this.leHeadingTrue = const Value.absent(),
  });
  RunwayTableCompanion.insert({
    this.id = const Value.absent(),
    required int airportId,
    required String designator,
    this.lengthFt = const Value.absent(),
    this.widthFt = const Value.absent(),
    this.surface = const Value.absent(),
    this.lighted = const Value.absent(),
    this.closed = const Value.absent(),
    this.heDesignator = const Value.absent(),
    this.heLatitude = const Value.absent(),
    this.heLongitude = const Value.absent(),
    this.heElevationFt = const Value.absent(),
    this.heHeadingTrue = const Value.absent(),
    this.leDesignator = const Value.absent(),
    this.leLatitude = const Value.absent(),
    this.leLongitude = const Value.absent(),
    this.leElevationFt = const Value.absent(),
    this.leHeadingTrue = const Value.absent(),
  }) : airportId = Value(airportId),
       designator = Value(designator);
  static Insertable<RunwayEntry> custom({
    Expression<int>? id,
    Expression<int>? airportId,
    Expression<String>? designator,
    Expression<double>? lengthFt,
    Expression<double>? widthFt,
    Expression<String>? surface,
    Expression<bool>? lighted,
    Expression<bool>? closed,
    Expression<String>? heDesignator,
    Expression<double>? heLatitude,
    Expression<double>? heLongitude,
    Expression<double>? heElevationFt,
    Expression<double>? heHeadingTrue,
    Expression<String>? leDesignator,
    Expression<double>? leLatitude,
    Expression<double>? leLongitude,
    Expression<double>? leElevationFt,
    Expression<double>? leHeadingTrue,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (airportId != null) 'airport_id': airportId,
      if (designator != null) 'designator': designator,
      if (lengthFt != null) 'length_ft': lengthFt,
      if (widthFt != null) 'width_ft': widthFt,
      if (surface != null) 'surface': surface,
      if (lighted != null) 'lighted': lighted,
      if (closed != null) 'closed': closed,
      if (heDesignator != null) 'he_designator': heDesignator,
      if (heLatitude != null) 'he_latitude': heLatitude,
      if (heLongitude != null) 'he_longitude': heLongitude,
      if (heElevationFt != null) 'he_elevation_ft': heElevationFt,
      if (heHeadingTrue != null) 'he_heading_true': heHeadingTrue,
      if (leDesignator != null) 'le_designator': leDesignator,
      if (leLatitude != null) 'le_latitude': leLatitude,
      if (leLongitude != null) 'le_longitude': leLongitude,
      if (leElevationFt != null) 'le_elevation_ft': leElevationFt,
      if (leHeadingTrue != null) 'le_heading_true': leHeadingTrue,
    });
  }

  RunwayTableCompanion copyWith({
    Value<int>? id,
    Value<int>? airportId,
    Value<String>? designator,
    Value<double?>? lengthFt,
    Value<double?>? widthFt,
    Value<String?>? surface,
    Value<bool>? lighted,
    Value<bool>? closed,
    Value<String?>? heDesignator,
    Value<double?>? heLatitude,
    Value<double?>? heLongitude,
    Value<double?>? heElevationFt,
    Value<double?>? heHeadingTrue,
    Value<String?>? leDesignator,
    Value<double?>? leLatitude,
    Value<double?>? leLongitude,
    Value<double?>? leElevationFt,
    Value<double?>? leHeadingTrue,
  }) {
    return RunwayTableCompanion(
      id: id ?? this.id,
      airportId: airportId ?? this.airportId,
      designator: designator ?? this.designator,
      lengthFt: lengthFt ?? this.lengthFt,
      widthFt: widthFt ?? this.widthFt,
      surface: surface ?? this.surface,
      lighted: lighted ?? this.lighted,
      closed: closed ?? this.closed,
      heDesignator: heDesignator ?? this.heDesignator,
      heLatitude: heLatitude ?? this.heLatitude,
      heLongitude: heLongitude ?? this.heLongitude,
      heElevationFt: heElevationFt ?? this.heElevationFt,
      heHeadingTrue: heHeadingTrue ?? this.heHeadingTrue,
      leDesignator: leDesignator ?? this.leDesignator,
      leLatitude: leLatitude ?? this.leLatitude,
      leLongitude: leLongitude ?? this.leLongitude,
      leElevationFt: leElevationFt ?? this.leElevationFt,
      leHeadingTrue: leHeadingTrue ?? this.leHeadingTrue,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (airportId.present) {
      map['airport_id'] = Variable<int>(airportId.value);
    }
    if (designator.present) {
      map['designator'] = Variable<String>(designator.value);
    }
    if (lengthFt.present) {
      map['length_ft'] = Variable<double>(lengthFt.value);
    }
    if (widthFt.present) {
      map['width_ft'] = Variable<double>(widthFt.value);
    }
    if (surface.present) {
      map['surface'] = Variable<String>(surface.value);
    }
    if (lighted.present) {
      map['lighted'] = Variable<bool>(lighted.value);
    }
    if (closed.present) {
      map['closed'] = Variable<bool>(closed.value);
    }
    if (heDesignator.present) {
      map['he_designator'] = Variable<String>(heDesignator.value);
    }
    if (heLatitude.present) {
      map['he_latitude'] = Variable<double>(heLatitude.value);
    }
    if (heLongitude.present) {
      map['he_longitude'] = Variable<double>(heLongitude.value);
    }
    if (heElevationFt.present) {
      map['he_elevation_ft'] = Variable<double>(heElevationFt.value);
    }
    if (heHeadingTrue.present) {
      map['he_heading_true'] = Variable<double>(heHeadingTrue.value);
    }
    if (leDesignator.present) {
      map['le_designator'] = Variable<String>(leDesignator.value);
    }
    if (leLatitude.present) {
      map['le_latitude'] = Variable<double>(leLatitude.value);
    }
    if (leLongitude.present) {
      map['le_longitude'] = Variable<double>(leLongitude.value);
    }
    if (leElevationFt.present) {
      map['le_elevation_ft'] = Variable<double>(leElevationFt.value);
    }
    if (leHeadingTrue.present) {
      map['le_heading_true'] = Variable<double>(leHeadingTrue.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RunwayTableCompanion(')
          ..write('id: $id, ')
          ..write('airportId: $airportId, ')
          ..write('designator: $designator, ')
          ..write('lengthFt: $lengthFt, ')
          ..write('widthFt: $widthFt, ')
          ..write('surface: $surface, ')
          ..write('lighted: $lighted, ')
          ..write('closed: $closed, ')
          ..write('heDesignator: $heDesignator, ')
          ..write('heLatitude: $heLatitude, ')
          ..write('heLongitude: $heLongitude, ')
          ..write('heElevationFt: $heElevationFt, ')
          ..write('heHeadingTrue: $heHeadingTrue, ')
          ..write('leDesignator: $leDesignator, ')
          ..write('leLatitude: $leLatitude, ')
          ..write('leLongitude: $leLongitude, ')
          ..write('leElevationFt: $leElevationFt, ')
          ..write('leHeadingTrue: $leHeadingTrue')
          ..write(')'))
        .toString();
  }
}

class $FrequencyTableTable extends FrequencyTable
    with TableInfo<$FrequencyTableTable, FrequencyEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FrequencyTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _airportIdMeta = const VerificationMeta(
    'airportId',
  );
  @override
  late final GeneratedColumn<int> airportId = GeneratedColumn<int>(
    'airport_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _frequencyMhzMeta = const VerificationMeta(
    'frequencyMhz',
  );
  @override
  late final GeneratedColumn<double> frequencyMhz = GeneratedColumn<double>(
    'frequency_mhz',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    airportId,
    type,
    description,
    frequencyMhz,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'frequencies';
  @override
  VerificationContext validateIntegrity(
    Insertable<FrequencyEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('airport_id')) {
      context.handle(
        _airportIdMeta,
        airportId.isAcceptableOrUnknown(data['airport_id']!, _airportIdMeta),
      );
    } else if (isInserting) {
      context.missing(_airportIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('frequency_mhz')) {
      context.handle(
        _frequencyMhzMeta,
        frequencyMhz.isAcceptableOrUnknown(
          data['frequency_mhz']!,
          _frequencyMhzMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_frequencyMhzMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FrequencyEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FrequencyEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      airportId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}airport_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      frequencyMhz: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}frequency_mhz'],
      )!,
    );
  }

  @override
  $FrequencyTableTable createAlias(String alias) {
    return $FrequencyTableTable(attachedDatabase, alias);
  }
}

class FrequencyEntry extends DataClass implements Insertable<FrequencyEntry> {
  final int id;
  final int airportId;
  final String type;
  final String? description;
  final double frequencyMhz;
  const FrequencyEntry({
    required this.id,
    required this.airportId,
    required this.type,
    this.description,
    required this.frequencyMhz,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['airport_id'] = Variable<int>(airportId);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['frequency_mhz'] = Variable<double>(frequencyMhz);
    return map;
  }

  FrequencyTableCompanion toCompanion(bool nullToAbsent) {
    return FrequencyTableCompanion(
      id: Value(id),
      airportId: Value(airportId),
      type: Value(type),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      frequencyMhz: Value(frequencyMhz),
    );
  }

  factory FrequencyEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FrequencyEntry(
      id: serializer.fromJson<int>(json['id']),
      airportId: serializer.fromJson<int>(json['airportId']),
      type: serializer.fromJson<String>(json['type']),
      description: serializer.fromJson<String?>(json['description']),
      frequencyMhz: serializer.fromJson<double>(json['frequencyMhz']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'airportId': serializer.toJson<int>(airportId),
      'type': serializer.toJson<String>(type),
      'description': serializer.toJson<String?>(description),
      'frequencyMhz': serializer.toJson<double>(frequencyMhz),
    };
  }

  FrequencyEntry copyWith({
    int? id,
    int? airportId,
    String? type,
    Value<String?> description = const Value.absent(),
    double? frequencyMhz,
  }) => FrequencyEntry(
    id: id ?? this.id,
    airportId: airportId ?? this.airportId,
    type: type ?? this.type,
    description: description.present ? description.value : this.description,
    frequencyMhz: frequencyMhz ?? this.frequencyMhz,
  );
  FrequencyEntry copyWithCompanion(FrequencyTableCompanion data) {
    return FrequencyEntry(
      id: data.id.present ? data.id.value : this.id,
      airportId: data.airportId.present ? data.airportId.value : this.airportId,
      type: data.type.present ? data.type.value : this.type,
      description: data.description.present
          ? data.description.value
          : this.description,
      frequencyMhz: data.frequencyMhz.present
          ? data.frequencyMhz.value
          : this.frequencyMhz,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FrequencyEntry(')
          ..write('id: $id, ')
          ..write('airportId: $airportId, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('frequencyMhz: $frequencyMhz')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, airportId, type, description, frequencyMhz);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FrequencyEntry &&
          other.id == this.id &&
          other.airportId == this.airportId &&
          other.type == this.type &&
          other.description == this.description &&
          other.frequencyMhz == this.frequencyMhz);
}

class FrequencyTableCompanion extends UpdateCompanion<FrequencyEntry> {
  final Value<int> id;
  final Value<int> airportId;
  final Value<String> type;
  final Value<String?> description;
  final Value<double> frequencyMhz;
  const FrequencyTableCompanion({
    this.id = const Value.absent(),
    this.airportId = const Value.absent(),
    this.type = const Value.absent(),
    this.description = const Value.absent(),
    this.frequencyMhz = const Value.absent(),
  });
  FrequencyTableCompanion.insert({
    this.id = const Value.absent(),
    required int airportId,
    required String type,
    this.description = const Value.absent(),
    required double frequencyMhz,
  }) : airportId = Value(airportId),
       type = Value(type),
       frequencyMhz = Value(frequencyMhz);
  static Insertable<FrequencyEntry> custom({
    Expression<int>? id,
    Expression<int>? airportId,
    Expression<String>? type,
    Expression<String>? description,
    Expression<double>? frequencyMhz,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (airportId != null) 'airport_id': airportId,
      if (type != null) 'type': type,
      if (description != null) 'description': description,
      if (frequencyMhz != null) 'frequency_mhz': frequencyMhz,
    });
  }

  FrequencyTableCompanion copyWith({
    Value<int>? id,
    Value<int>? airportId,
    Value<String>? type,
    Value<String?>? description,
    Value<double>? frequencyMhz,
  }) {
    return FrequencyTableCompanion(
      id: id ?? this.id,
      airportId: airportId ?? this.airportId,
      type: type ?? this.type,
      description: description ?? this.description,
      frequencyMhz: frequencyMhz ?? this.frequencyMhz,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (airportId.present) {
      map['airport_id'] = Variable<int>(airportId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (frequencyMhz.present) {
      map['frequency_mhz'] = Variable<double>(frequencyMhz.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FrequencyTableCompanion(')
          ..write('id: $id, ')
          ..write('airportId: $airportId, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('frequencyMhz: $frequencyMhz')
          ..write(')'))
        .toString();
  }
}

class $NavaidTableTable extends NavaidTable
    with TableInfo<$NavaidTableTable, NavaidEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NavaidTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _identMeta = const VerificationMeta('ident');
  @override
  late final GeneratedColumn<String> ident = GeneratedColumn<String>(
    'ident',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _elevationFtMeta = const VerificationMeta(
    'elevationFt',
  );
  @override
  late final GeneratedColumn<double> elevationFt = GeneratedColumn<double>(
    'elevation_ft',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _frequencyMeta = const VerificationMeta(
    'frequency',
  );
  @override
  late final GeneratedColumn<double> frequency = GeneratedColumn<double>(
    'frequency',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _magneticVariationMeta = const VerificationMeta(
    'magneticVariation',
  );
  @override
  late final GeneratedColumn<double> magneticVariation =
      GeneratedColumn<double>(
        'magnetic_variation',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _rangeNmMeta = const VerificationMeta(
    'rangeNm',
  );
  @override
  late final GeneratedColumn<double> rangeNm = GeneratedColumn<double>(
    'range_nm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ident,
    name,
    type,
    latitude,
    longitude,
    elevationFt,
    frequency,
    magneticVariation,
    rangeNm,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'navaids';
  @override
  VerificationContext validateIntegrity(
    Insertable<NavaidEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ident')) {
      context.handle(
        _identMeta,
        ident.isAcceptableOrUnknown(data['ident']!, _identMeta),
      );
    } else if (isInserting) {
      context.missing(_identMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('elevation_ft')) {
      context.handle(
        _elevationFtMeta,
        elevationFt.isAcceptableOrUnknown(
          data['elevation_ft']!,
          _elevationFtMeta,
        ),
      );
    }
    if (data.containsKey('frequency')) {
      context.handle(
        _frequencyMeta,
        frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta),
      );
    }
    if (data.containsKey('magnetic_variation')) {
      context.handle(
        _magneticVariationMeta,
        magneticVariation.isAcceptableOrUnknown(
          data['magnetic_variation']!,
          _magneticVariationMeta,
        ),
      );
    }
    if (data.containsKey('range_nm')) {
      context.handle(
        _rangeNmMeta,
        rangeNm.isAcceptableOrUnknown(data['range_nm']!, _rangeNmMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NavaidEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NavaidEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ident: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ident'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      elevationFt: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}elevation_ft'],
      ),
      frequency: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}frequency'],
      ),
      magneticVariation: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}magnetic_variation'],
      ),
      rangeNm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}range_nm'],
      ),
    );
  }

  @override
  $NavaidTableTable createAlias(String alias) {
    return $NavaidTableTable(attachedDatabase, alias);
  }
}

class NavaidEntry extends DataClass implements Insertable<NavaidEntry> {
  final int id;
  final String ident;
  final String name;
  final String type;
  final double latitude;
  final double longitude;
  final double? elevationFt;
  final double? frequency;
  final double? magneticVariation;
  final double? rangeNm;
  const NavaidEntry({
    required this.id,
    required this.ident,
    required this.name,
    required this.type,
    required this.latitude,
    required this.longitude,
    this.elevationFt,
    this.frequency,
    this.magneticVariation,
    this.rangeNm,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ident'] = Variable<String>(ident);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    if (!nullToAbsent || elevationFt != null) {
      map['elevation_ft'] = Variable<double>(elevationFt);
    }
    if (!nullToAbsent || frequency != null) {
      map['frequency'] = Variable<double>(frequency);
    }
    if (!nullToAbsent || magneticVariation != null) {
      map['magnetic_variation'] = Variable<double>(magneticVariation);
    }
    if (!nullToAbsent || rangeNm != null) {
      map['range_nm'] = Variable<double>(rangeNm);
    }
    return map;
  }

  NavaidTableCompanion toCompanion(bool nullToAbsent) {
    return NavaidTableCompanion(
      id: Value(id),
      ident: Value(ident),
      name: Value(name),
      type: Value(type),
      latitude: Value(latitude),
      longitude: Value(longitude),
      elevationFt: elevationFt == null && nullToAbsent
          ? const Value.absent()
          : Value(elevationFt),
      frequency: frequency == null && nullToAbsent
          ? const Value.absent()
          : Value(frequency),
      magneticVariation: magneticVariation == null && nullToAbsent
          ? const Value.absent()
          : Value(magneticVariation),
      rangeNm: rangeNm == null && nullToAbsent
          ? const Value.absent()
          : Value(rangeNm),
    );
  }

  factory NavaidEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NavaidEntry(
      id: serializer.fromJson<int>(json['id']),
      ident: serializer.fromJson<String>(json['ident']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      elevationFt: serializer.fromJson<double?>(json['elevationFt']),
      frequency: serializer.fromJson<double?>(json['frequency']),
      magneticVariation: serializer.fromJson<double?>(
        json['magneticVariation'],
      ),
      rangeNm: serializer.fromJson<double?>(json['rangeNm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ident': serializer.toJson<String>(ident),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'elevationFt': serializer.toJson<double?>(elevationFt),
      'frequency': serializer.toJson<double?>(frequency),
      'magneticVariation': serializer.toJson<double?>(magneticVariation),
      'rangeNm': serializer.toJson<double?>(rangeNm),
    };
  }

  NavaidEntry copyWith({
    int? id,
    String? ident,
    String? name,
    String? type,
    double? latitude,
    double? longitude,
    Value<double?> elevationFt = const Value.absent(),
    Value<double?> frequency = const Value.absent(),
    Value<double?> magneticVariation = const Value.absent(),
    Value<double?> rangeNm = const Value.absent(),
  }) => NavaidEntry(
    id: id ?? this.id,
    ident: ident ?? this.ident,
    name: name ?? this.name,
    type: type ?? this.type,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    elevationFt: elevationFt.present ? elevationFt.value : this.elevationFt,
    frequency: frequency.present ? frequency.value : this.frequency,
    magneticVariation: magneticVariation.present
        ? magneticVariation.value
        : this.magneticVariation,
    rangeNm: rangeNm.present ? rangeNm.value : this.rangeNm,
  );
  NavaidEntry copyWithCompanion(NavaidTableCompanion data) {
    return NavaidEntry(
      id: data.id.present ? data.id.value : this.id,
      ident: data.ident.present ? data.ident.value : this.ident,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      elevationFt: data.elevationFt.present
          ? data.elevationFt.value
          : this.elevationFt,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      magneticVariation: data.magneticVariation.present
          ? data.magneticVariation.value
          : this.magneticVariation,
      rangeNm: data.rangeNm.present ? data.rangeNm.value : this.rangeNm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NavaidEntry(')
          ..write('id: $id, ')
          ..write('ident: $ident, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('elevationFt: $elevationFt, ')
          ..write('frequency: $frequency, ')
          ..write('magneticVariation: $magneticVariation, ')
          ..write('rangeNm: $rangeNm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ident,
    name,
    type,
    latitude,
    longitude,
    elevationFt,
    frequency,
    magneticVariation,
    rangeNm,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NavaidEntry &&
          other.id == this.id &&
          other.ident == this.ident &&
          other.name == this.name &&
          other.type == this.type &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.elevationFt == this.elevationFt &&
          other.frequency == this.frequency &&
          other.magneticVariation == this.magneticVariation &&
          other.rangeNm == this.rangeNm);
}

class NavaidTableCompanion extends UpdateCompanion<NavaidEntry> {
  final Value<int> id;
  final Value<String> ident;
  final Value<String> name;
  final Value<String> type;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<double?> elevationFt;
  final Value<double?> frequency;
  final Value<double?> magneticVariation;
  final Value<double?> rangeNm;
  const NavaidTableCompanion({
    this.id = const Value.absent(),
    this.ident = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.elevationFt = const Value.absent(),
    this.frequency = const Value.absent(),
    this.magneticVariation = const Value.absent(),
    this.rangeNm = const Value.absent(),
  });
  NavaidTableCompanion.insert({
    this.id = const Value.absent(),
    required String ident,
    required String name,
    required String type,
    required double latitude,
    required double longitude,
    this.elevationFt = const Value.absent(),
    this.frequency = const Value.absent(),
    this.magneticVariation = const Value.absent(),
    this.rangeNm = const Value.absent(),
  }) : ident = Value(ident),
       name = Value(name),
       type = Value(type),
       latitude = Value(latitude),
       longitude = Value(longitude);
  static Insertable<NavaidEntry> custom({
    Expression<int>? id,
    Expression<String>? ident,
    Expression<String>? name,
    Expression<String>? type,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? elevationFt,
    Expression<double>? frequency,
    Expression<double>? magneticVariation,
    Expression<double>? rangeNm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ident != null) 'ident': ident,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (elevationFt != null) 'elevation_ft': elevationFt,
      if (frequency != null) 'frequency': frequency,
      if (magneticVariation != null) 'magnetic_variation': magneticVariation,
      if (rangeNm != null) 'range_nm': rangeNm,
    });
  }

  NavaidTableCompanion copyWith({
    Value<int>? id,
    Value<String>? ident,
    Value<String>? name,
    Value<String>? type,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<double?>? elevationFt,
    Value<double?>? frequency,
    Value<double?>? magneticVariation,
    Value<double?>? rangeNm,
  }) {
    return NavaidTableCompanion(
      id: id ?? this.id,
      ident: ident ?? this.ident,
      name: name ?? this.name,
      type: type ?? this.type,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      elevationFt: elevationFt ?? this.elevationFt,
      frequency: frequency ?? this.frequency,
      magneticVariation: magneticVariation ?? this.magneticVariation,
      rangeNm: rangeNm ?? this.rangeNm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ident.present) {
      map['ident'] = Variable<String>(ident.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (elevationFt.present) {
      map['elevation_ft'] = Variable<double>(elevationFt.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<double>(frequency.value);
    }
    if (magneticVariation.present) {
      map['magnetic_variation'] = Variable<double>(magneticVariation.value);
    }
    if (rangeNm.present) {
      map['range_nm'] = Variable<double>(rangeNm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NavaidTableCompanion(')
          ..write('id: $id, ')
          ..write('ident: $ident, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('elevationFt: $elevationFt, ')
          ..write('frequency: $frequency, ')
          ..write('magneticVariation: $magneticVariation, ')
          ..write('rangeNm: $rangeNm')
          ..write(')'))
        .toString();
  }
}

class $SettingsTableTable extends SettingsTable
    with TableInfo<$SettingsTableTable, SettingEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SettingEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingEntry(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SettingsTableTable createAlias(String alias) {
    return $SettingsTableTable(attachedDatabase, alias);
  }
}

class SettingEntry extends DataClass implements Insertable<SettingEntry> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const SettingEntry({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SettingsTableCompanion toCompanion(bool nullToAbsent) {
    return SettingsTableCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory SettingEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingEntry(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SettingEntry copyWith({String? key, String? value, DateTime? updatedAt}) =>
      SettingEntry(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  SettingEntry copyWithCompanion(SettingsTableCompanion data) {
    return SettingEntry(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingEntry(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingEntry &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class SettingsTableCompanion extends UpdateCompanion<SettingEntry> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SettingsTableCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsTableCompanion.insert({
    required String key,
    required String value,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       updatedAt = Value(updatedAt);
  static Insertable<SettingEntry> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsTableCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SettingsTableCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsTableCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FavoritesTableTable extends FavoritesTable
    with TableInfo<$FavoritesTableTable, FavoriteEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceIdMeta = const VerificationMeta(
    'referenceId',
  );
  @override
  late final GeneratedColumn<int> referenceId = GeneratedColumn<int>(
    'reference_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    referenceId,
    label,
    sortOrder,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorites';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('reference_id')) {
      context.handle(
        _referenceIdMeta,
        referenceId.isAcceptableOrUnknown(
          data['reference_id']!,
          _referenceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_referenceIdMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoriteEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      referenceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reference_id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FavoritesTableTable createAlias(String alias) {
    return $FavoritesTableTable(attachedDatabase, alias);
  }
}

class FavoriteEntry extends DataClass implements Insertable<FavoriteEntry> {
  final int id;
  final String type;
  final int referenceId;
  final String? label;
  final int sortOrder;
  final DateTime createdAt;
  const FavoriteEntry({
    required this.id,
    required this.type,
    required this.referenceId,
    this.label,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['reference_id'] = Variable<int>(referenceId);
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FavoritesTableCompanion toCompanion(bool nullToAbsent) {
    return FavoritesTableCompanion(
      id: Value(id),
      type: Value(type),
      referenceId: Value(referenceId),
      label: label == null && nullToAbsent
          ? const Value.absent()
          : Value(label),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory FavoriteEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteEntry(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      referenceId: serializer.fromJson<int>(json['referenceId']),
      label: serializer.fromJson<String?>(json['label']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'referenceId': serializer.toJson<int>(referenceId),
      'label': serializer.toJson<String?>(label),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FavoriteEntry copyWith({
    int? id,
    String? type,
    int? referenceId,
    Value<String?> label = const Value.absent(),
    int? sortOrder,
    DateTime? createdAt,
  }) => FavoriteEntry(
    id: id ?? this.id,
    type: type ?? this.type,
    referenceId: referenceId ?? this.referenceId,
    label: label.present ? label.value : this.label,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  FavoriteEntry copyWithCompanion(FavoritesTableCompanion data) {
    return FavoriteEntry(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      referenceId: data.referenceId.present
          ? data.referenceId.value
          : this.referenceId,
      label: data.label.present ? data.label.value : this.label,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteEntry(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('referenceId: $referenceId, ')
          ..write('label: $label, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, referenceId, label, sortOrder, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteEntry &&
          other.id == this.id &&
          other.type == this.type &&
          other.referenceId == this.referenceId &&
          other.label == this.label &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class FavoritesTableCompanion extends UpdateCompanion<FavoriteEntry> {
  final Value<int> id;
  final Value<String> type;
  final Value<int> referenceId;
  final Value<String?> label;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  const FavoritesTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.label = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FavoritesTableCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    required int referenceId,
    this.label = const Value.absent(),
    this.sortOrder = const Value.absent(),
    required DateTime createdAt,
  }) : type = Value(type),
       referenceId = Value(referenceId),
       createdAt = Value(createdAt);
  static Insertable<FavoriteEntry> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<int>? referenceId,
    Expression<String>? label,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (referenceId != null) 'reference_id': referenceId,
      if (label != null) 'label': label,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FavoritesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? type,
    Value<int>? referenceId,
    Value<String?>? label,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
  }) {
    return FavoritesTableCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      referenceId: referenceId ?? this.referenceId,
      label: label ?? this.label,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<int>(referenceId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesTableCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('referenceId: $referenceId, ')
          ..write('label: $label, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $RoutesTableTable extends RoutesTable
    with TableInfo<$RoutesTableTable, RouteEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _waypointsJsonMeta = const VerificationMeta(
    'waypointsJson',
  );
  @override
  late final GeneratedColumn<String> waypointsJson = GeneratedColumn<String>(
    'waypoints_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalDistanceNmMeta = const VerificationMeta(
    'totalDistanceNm',
  );
  @override
  late final GeneratedColumn<double> totalDistanceNm = GeneratedColumn<double>(
    'total_distance_nm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalTimeSecondsMeta = const VerificationMeta(
    'totalTimeSeconds',
  );
  @override
  late final GeneratedColumn<int> totalTimeSeconds = GeneratedColumn<int>(
    'total_time_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _aircraftProfileIdMeta = const VerificationMeta(
    'aircraftProfileId',
  );
  @override
  late final GeneratedColumn<String> aircraftProfileId =
      GeneratedColumn<String>(
        'aircraft_profile_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    waypointsJson,
    totalDistanceNm,
    totalTimeSeconds,
    aircraftProfileId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routes';
  @override
  VerificationContext validateIntegrity(
    Insertable<RouteEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('waypoints_json')) {
      context.handle(
        _waypointsJsonMeta,
        waypointsJson.isAcceptableOrUnknown(
          data['waypoints_json']!,
          _waypointsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_waypointsJsonMeta);
    }
    if (data.containsKey('total_distance_nm')) {
      context.handle(
        _totalDistanceNmMeta,
        totalDistanceNm.isAcceptableOrUnknown(
          data['total_distance_nm']!,
          _totalDistanceNmMeta,
        ),
      );
    }
    if (data.containsKey('total_time_seconds')) {
      context.handle(
        _totalTimeSecondsMeta,
        totalTimeSeconds.isAcceptableOrUnknown(
          data['total_time_seconds']!,
          _totalTimeSecondsMeta,
        ),
      );
    }
    if (data.containsKey('aircraft_profile_id')) {
      context.handle(
        _aircraftProfileIdMeta,
        aircraftProfileId.isAcceptableOrUnknown(
          data['aircraft_profile_id']!,
          _aircraftProfileIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RouteEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RouteEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      waypointsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}waypoints_json'],
      )!,
      totalDistanceNm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_distance_nm'],
      ),
      totalTimeSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_time_seconds'],
      ),
      aircraftProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}aircraft_profile_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RoutesTableTable createAlias(String alias) {
    return $RoutesTableTable(attachedDatabase, alias);
  }
}

class RouteEntry extends DataClass implements Insertable<RouteEntry> {
  final int id;
  final String name;
  final String? description;
  final String waypointsJson;
  final double? totalDistanceNm;
  final int? totalTimeSeconds;
  final String? aircraftProfileId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RouteEntry({
    required this.id,
    required this.name,
    this.description,
    required this.waypointsJson,
    this.totalDistanceNm,
    this.totalTimeSeconds,
    this.aircraftProfileId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['waypoints_json'] = Variable<String>(waypointsJson);
    if (!nullToAbsent || totalDistanceNm != null) {
      map['total_distance_nm'] = Variable<double>(totalDistanceNm);
    }
    if (!nullToAbsent || totalTimeSeconds != null) {
      map['total_time_seconds'] = Variable<int>(totalTimeSeconds);
    }
    if (!nullToAbsent || aircraftProfileId != null) {
      map['aircraft_profile_id'] = Variable<String>(aircraftProfileId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RoutesTableCompanion toCompanion(bool nullToAbsent) {
    return RoutesTableCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      waypointsJson: Value(waypointsJson),
      totalDistanceNm: totalDistanceNm == null && nullToAbsent
          ? const Value.absent()
          : Value(totalDistanceNm),
      totalTimeSeconds: totalTimeSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(totalTimeSeconds),
      aircraftProfileId: aircraftProfileId == null && nullToAbsent
          ? const Value.absent()
          : Value(aircraftProfileId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RouteEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RouteEntry(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      waypointsJson: serializer.fromJson<String>(json['waypointsJson']),
      totalDistanceNm: serializer.fromJson<double?>(json['totalDistanceNm']),
      totalTimeSeconds: serializer.fromJson<int?>(json['totalTimeSeconds']),
      aircraftProfileId: serializer.fromJson<String?>(
        json['aircraftProfileId'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'waypointsJson': serializer.toJson<String>(waypointsJson),
      'totalDistanceNm': serializer.toJson<double?>(totalDistanceNm),
      'totalTimeSeconds': serializer.toJson<int?>(totalTimeSeconds),
      'aircraftProfileId': serializer.toJson<String?>(aircraftProfileId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RouteEntry copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    String? waypointsJson,
    Value<double?> totalDistanceNm = const Value.absent(),
    Value<int?> totalTimeSeconds = const Value.absent(),
    Value<String?> aircraftProfileId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => RouteEntry(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    waypointsJson: waypointsJson ?? this.waypointsJson,
    totalDistanceNm: totalDistanceNm.present
        ? totalDistanceNm.value
        : this.totalDistanceNm,
    totalTimeSeconds: totalTimeSeconds.present
        ? totalTimeSeconds.value
        : this.totalTimeSeconds,
    aircraftProfileId: aircraftProfileId.present
        ? aircraftProfileId.value
        : this.aircraftProfileId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RouteEntry copyWithCompanion(RoutesTableCompanion data) {
    return RouteEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      waypointsJson: data.waypointsJson.present
          ? data.waypointsJson.value
          : this.waypointsJson,
      totalDistanceNm: data.totalDistanceNm.present
          ? data.totalDistanceNm.value
          : this.totalDistanceNm,
      totalTimeSeconds: data.totalTimeSeconds.present
          ? data.totalTimeSeconds.value
          : this.totalTimeSeconds,
      aircraftProfileId: data.aircraftProfileId.present
          ? data.aircraftProfileId.value
          : this.aircraftProfileId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RouteEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('waypointsJson: $waypointsJson, ')
          ..write('totalDistanceNm: $totalDistanceNm, ')
          ..write('totalTimeSeconds: $totalTimeSeconds, ')
          ..write('aircraftProfileId: $aircraftProfileId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    waypointsJson,
    totalDistanceNm,
    totalTimeSeconds,
    aircraftProfileId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RouteEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.waypointsJson == this.waypointsJson &&
          other.totalDistanceNm == this.totalDistanceNm &&
          other.totalTimeSeconds == this.totalTimeSeconds &&
          other.aircraftProfileId == this.aircraftProfileId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RoutesTableCompanion extends UpdateCompanion<RouteEntry> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> waypointsJson;
  final Value<double?> totalDistanceNm;
  final Value<int?> totalTimeSeconds;
  final Value<String?> aircraftProfileId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const RoutesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.waypointsJson = const Value.absent(),
    this.totalDistanceNm = const Value.absent(),
    this.totalTimeSeconds = const Value.absent(),
    this.aircraftProfileId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RoutesTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required String waypointsJson,
    this.totalDistanceNm = const Value.absent(),
    this.totalTimeSeconds = const Value.absent(),
    this.aircraftProfileId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : name = Value(name),
       waypointsJson = Value(waypointsJson),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<RouteEntry> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? waypointsJson,
    Expression<double>? totalDistanceNm,
    Expression<int>? totalTimeSeconds,
    Expression<String>? aircraftProfileId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (waypointsJson != null) 'waypoints_json': waypointsJson,
      if (totalDistanceNm != null) 'total_distance_nm': totalDistanceNm,
      if (totalTimeSeconds != null) 'total_time_seconds': totalTimeSeconds,
      if (aircraftProfileId != null) 'aircraft_profile_id': aircraftProfileId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RoutesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String>? waypointsJson,
    Value<double?>? totalDistanceNm,
    Value<int?>? totalTimeSeconds,
    Value<String?>? aircraftProfileId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return RoutesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      waypointsJson: waypointsJson ?? this.waypointsJson,
      totalDistanceNm: totalDistanceNm ?? this.totalDistanceNm,
      totalTimeSeconds: totalTimeSeconds ?? this.totalTimeSeconds,
      aircraftProfileId: aircraftProfileId ?? this.aircraftProfileId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (waypointsJson.present) {
      map['waypoints_json'] = Variable<String>(waypointsJson.value);
    }
    if (totalDistanceNm.present) {
      map['total_distance_nm'] = Variable<double>(totalDistanceNm.value);
    }
    if (totalTimeSeconds.present) {
      map['total_time_seconds'] = Variable<int>(totalTimeSeconds.value);
    }
    if (aircraftProfileId.present) {
      map['aircraft_profile_id'] = Variable<String>(aircraftProfileId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('waypointsJson: $waypointsJson, ')
          ..write('totalDistanceNm: $totalDistanceNm, ')
          ..write('totalTimeSeconds: $totalTimeSeconds, ')
          ..write('aircraftProfileId: $aircraftProfileId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FlightLogsTableTable extends FlightLogsTable
    with TableInfo<$FlightLogsTableTable, FlightLogEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FlightLogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _routeIdMeta = const VerificationMeta(
    'routeId',
  );
  @override
  late final GeneratedColumn<int> routeId = GeneratedColumn<int>(
    'route_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _departureIcaoMeta = const VerificationMeta(
    'departureIcao',
  );
  @override
  late final GeneratedColumn<String> departureIcao = GeneratedColumn<String>(
    'departure_icao',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _arrivalIcaoMeta = const VerificationMeta(
    'arrivalIcao',
  );
  @override
  late final GeneratedColumn<String> arrivalIcao = GeneratedColumn<String>(
    'arrival_icao',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _departureTimeMeta = const VerificationMeta(
    'departureTime',
  );
  @override
  late final GeneratedColumn<DateTime> departureTime =
      GeneratedColumn<DateTime>(
        'departure_time',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _arrivalTimeMeta = const VerificationMeta(
    'arrivalTime',
  );
  @override
  late final GeneratedColumn<DateTime> arrivalTime = GeneratedColumn<DateTime>(
    'arrival_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalDistanceNmMeta = const VerificationMeta(
    'totalDistanceNm',
  );
  @override
  late final GeneratedColumn<double> totalDistanceNm = GeneratedColumn<double>(
    'total_distance_nm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalFuelGallonsMeta = const VerificationMeta(
    'totalFuelGallons',
  );
  @override
  late final GeneratedColumn<double> totalFuelGallons = GeneratedColumn<double>(
    'total_fuel_gallons',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxAltitudeFtMeta = const VerificationMeta(
    'maxAltitudeFt',
  );
  @override
  late final GeneratedColumn<double> maxAltitudeFt = GeneratedColumn<double>(
    'max_altitude_ft',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _trackJsonMeta = const VerificationMeta(
    'trackJson',
  );
  @override
  late final GeneratedColumn<String> trackJson = GeneratedColumn<String>(
    'track_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    routeId,
    departureIcao,
    arrivalIcao,
    departureTime,
    arrivalTime,
    totalDistanceNm,
    totalFuelGallons,
    maxAltitudeFt,
    trackJson,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'flight_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<FlightLogEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('route_id')) {
      context.handle(
        _routeIdMeta,
        routeId.isAcceptableOrUnknown(data['route_id']!, _routeIdMeta),
      );
    }
    if (data.containsKey('departure_icao')) {
      context.handle(
        _departureIcaoMeta,
        departureIcao.isAcceptableOrUnknown(
          data['departure_icao']!,
          _departureIcaoMeta,
        ),
      );
    }
    if (data.containsKey('arrival_icao')) {
      context.handle(
        _arrivalIcaoMeta,
        arrivalIcao.isAcceptableOrUnknown(
          data['arrival_icao']!,
          _arrivalIcaoMeta,
        ),
      );
    }
    if (data.containsKey('departure_time')) {
      context.handle(
        _departureTimeMeta,
        departureTime.isAcceptableOrUnknown(
          data['departure_time']!,
          _departureTimeMeta,
        ),
      );
    }
    if (data.containsKey('arrival_time')) {
      context.handle(
        _arrivalTimeMeta,
        arrivalTime.isAcceptableOrUnknown(
          data['arrival_time']!,
          _arrivalTimeMeta,
        ),
      );
    }
    if (data.containsKey('total_distance_nm')) {
      context.handle(
        _totalDistanceNmMeta,
        totalDistanceNm.isAcceptableOrUnknown(
          data['total_distance_nm']!,
          _totalDistanceNmMeta,
        ),
      );
    }
    if (data.containsKey('total_fuel_gallons')) {
      context.handle(
        _totalFuelGallonsMeta,
        totalFuelGallons.isAcceptableOrUnknown(
          data['total_fuel_gallons']!,
          _totalFuelGallonsMeta,
        ),
      );
    }
    if (data.containsKey('max_altitude_ft')) {
      context.handle(
        _maxAltitudeFtMeta,
        maxAltitudeFt.isAcceptableOrUnknown(
          data['max_altitude_ft']!,
          _maxAltitudeFtMeta,
        ),
      );
    }
    if (data.containsKey('track_json')) {
      context.handle(
        _trackJsonMeta,
        trackJson.isAcceptableOrUnknown(data['track_json']!, _trackJsonMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FlightLogEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FlightLogEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      routeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}route_id'],
      ),
      departureIcao: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}departure_icao'],
      ),
      arrivalIcao: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}arrival_icao'],
      ),
      departureTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}departure_time'],
      ),
      arrivalTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}arrival_time'],
      ),
      totalDistanceNm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_distance_nm'],
      ),
      totalFuelGallons: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_fuel_gallons'],
      ),
      maxAltitudeFt: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_altitude_ft'],
      ),
      trackJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}track_json'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FlightLogsTableTable createAlias(String alias) {
    return $FlightLogsTableTable(attachedDatabase, alias);
  }
}

class FlightLogEntry extends DataClass implements Insertable<FlightLogEntry> {
  final int id;
  final int? routeId;
  final String? departureIcao;
  final String? arrivalIcao;
  final DateTime? departureTime;
  final DateTime? arrivalTime;
  final double? totalDistanceNm;
  final double? totalFuelGallons;
  final double? maxAltitudeFt;
  final String? trackJson;
  final String? notes;
  final DateTime createdAt;
  const FlightLogEntry({
    required this.id,
    this.routeId,
    this.departureIcao,
    this.arrivalIcao,
    this.departureTime,
    this.arrivalTime,
    this.totalDistanceNm,
    this.totalFuelGallons,
    this.maxAltitudeFt,
    this.trackJson,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || routeId != null) {
      map['route_id'] = Variable<int>(routeId);
    }
    if (!nullToAbsent || departureIcao != null) {
      map['departure_icao'] = Variable<String>(departureIcao);
    }
    if (!nullToAbsent || arrivalIcao != null) {
      map['arrival_icao'] = Variable<String>(arrivalIcao);
    }
    if (!nullToAbsent || departureTime != null) {
      map['departure_time'] = Variable<DateTime>(departureTime);
    }
    if (!nullToAbsent || arrivalTime != null) {
      map['arrival_time'] = Variable<DateTime>(arrivalTime);
    }
    if (!nullToAbsent || totalDistanceNm != null) {
      map['total_distance_nm'] = Variable<double>(totalDistanceNm);
    }
    if (!nullToAbsent || totalFuelGallons != null) {
      map['total_fuel_gallons'] = Variable<double>(totalFuelGallons);
    }
    if (!nullToAbsent || maxAltitudeFt != null) {
      map['max_altitude_ft'] = Variable<double>(maxAltitudeFt);
    }
    if (!nullToAbsent || trackJson != null) {
      map['track_json'] = Variable<String>(trackJson);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FlightLogsTableCompanion toCompanion(bool nullToAbsent) {
    return FlightLogsTableCompanion(
      id: Value(id),
      routeId: routeId == null && nullToAbsent
          ? const Value.absent()
          : Value(routeId),
      departureIcao: departureIcao == null && nullToAbsent
          ? const Value.absent()
          : Value(departureIcao),
      arrivalIcao: arrivalIcao == null && nullToAbsent
          ? const Value.absent()
          : Value(arrivalIcao),
      departureTime: departureTime == null && nullToAbsent
          ? const Value.absent()
          : Value(departureTime),
      arrivalTime: arrivalTime == null && nullToAbsent
          ? const Value.absent()
          : Value(arrivalTime),
      totalDistanceNm: totalDistanceNm == null && nullToAbsent
          ? const Value.absent()
          : Value(totalDistanceNm),
      totalFuelGallons: totalFuelGallons == null && nullToAbsent
          ? const Value.absent()
          : Value(totalFuelGallons),
      maxAltitudeFt: maxAltitudeFt == null && nullToAbsent
          ? const Value.absent()
          : Value(maxAltitudeFt),
      trackJson: trackJson == null && nullToAbsent
          ? const Value.absent()
          : Value(trackJson),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory FlightLogEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FlightLogEntry(
      id: serializer.fromJson<int>(json['id']),
      routeId: serializer.fromJson<int?>(json['routeId']),
      departureIcao: serializer.fromJson<String?>(json['departureIcao']),
      arrivalIcao: serializer.fromJson<String?>(json['arrivalIcao']),
      departureTime: serializer.fromJson<DateTime?>(json['departureTime']),
      arrivalTime: serializer.fromJson<DateTime?>(json['arrivalTime']),
      totalDistanceNm: serializer.fromJson<double?>(json['totalDistanceNm']),
      totalFuelGallons: serializer.fromJson<double?>(json['totalFuelGallons']),
      maxAltitudeFt: serializer.fromJson<double?>(json['maxAltitudeFt']),
      trackJson: serializer.fromJson<String?>(json['trackJson']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'routeId': serializer.toJson<int?>(routeId),
      'departureIcao': serializer.toJson<String?>(departureIcao),
      'arrivalIcao': serializer.toJson<String?>(arrivalIcao),
      'departureTime': serializer.toJson<DateTime?>(departureTime),
      'arrivalTime': serializer.toJson<DateTime?>(arrivalTime),
      'totalDistanceNm': serializer.toJson<double?>(totalDistanceNm),
      'totalFuelGallons': serializer.toJson<double?>(totalFuelGallons),
      'maxAltitudeFt': serializer.toJson<double?>(maxAltitudeFt),
      'trackJson': serializer.toJson<String?>(trackJson),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FlightLogEntry copyWith({
    int? id,
    Value<int?> routeId = const Value.absent(),
    Value<String?> departureIcao = const Value.absent(),
    Value<String?> arrivalIcao = const Value.absent(),
    Value<DateTime?> departureTime = const Value.absent(),
    Value<DateTime?> arrivalTime = const Value.absent(),
    Value<double?> totalDistanceNm = const Value.absent(),
    Value<double?> totalFuelGallons = const Value.absent(),
    Value<double?> maxAltitudeFt = const Value.absent(),
    Value<String?> trackJson = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => FlightLogEntry(
    id: id ?? this.id,
    routeId: routeId.present ? routeId.value : this.routeId,
    departureIcao: departureIcao.present
        ? departureIcao.value
        : this.departureIcao,
    arrivalIcao: arrivalIcao.present ? arrivalIcao.value : this.arrivalIcao,
    departureTime: departureTime.present
        ? departureTime.value
        : this.departureTime,
    arrivalTime: arrivalTime.present ? arrivalTime.value : this.arrivalTime,
    totalDistanceNm: totalDistanceNm.present
        ? totalDistanceNm.value
        : this.totalDistanceNm,
    totalFuelGallons: totalFuelGallons.present
        ? totalFuelGallons.value
        : this.totalFuelGallons,
    maxAltitudeFt: maxAltitudeFt.present
        ? maxAltitudeFt.value
        : this.maxAltitudeFt,
    trackJson: trackJson.present ? trackJson.value : this.trackJson,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  FlightLogEntry copyWithCompanion(FlightLogsTableCompanion data) {
    return FlightLogEntry(
      id: data.id.present ? data.id.value : this.id,
      routeId: data.routeId.present ? data.routeId.value : this.routeId,
      departureIcao: data.departureIcao.present
          ? data.departureIcao.value
          : this.departureIcao,
      arrivalIcao: data.arrivalIcao.present
          ? data.arrivalIcao.value
          : this.arrivalIcao,
      departureTime: data.departureTime.present
          ? data.departureTime.value
          : this.departureTime,
      arrivalTime: data.arrivalTime.present
          ? data.arrivalTime.value
          : this.arrivalTime,
      totalDistanceNm: data.totalDistanceNm.present
          ? data.totalDistanceNm.value
          : this.totalDistanceNm,
      totalFuelGallons: data.totalFuelGallons.present
          ? data.totalFuelGallons.value
          : this.totalFuelGallons,
      maxAltitudeFt: data.maxAltitudeFt.present
          ? data.maxAltitudeFt.value
          : this.maxAltitudeFt,
      trackJson: data.trackJson.present ? data.trackJson.value : this.trackJson,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FlightLogEntry(')
          ..write('id: $id, ')
          ..write('routeId: $routeId, ')
          ..write('departureIcao: $departureIcao, ')
          ..write('arrivalIcao: $arrivalIcao, ')
          ..write('departureTime: $departureTime, ')
          ..write('arrivalTime: $arrivalTime, ')
          ..write('totalDistanceNm: $totalDistanceNm, ')
          ..write('totalFuelGallons: $totalFuelGallons, ')
          ..write('maxAltitudeFt: $maxAltitudeFt, ')
          ..write('trackJson: $trackJson, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    routeId,
    departureIcao,
    arrivalIcao,
    departureTime,
    arrivalTime,
    totalDistanceNm,
    totalFuelGallons,
    maxAltitudeFt,
    trackJson,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FlightLogEntry &&
          other.id == this.id &&
          other.routeId == this.routeId &&
          other.departureIcao == this.departureIcao &&
          other.arrivalIcao == this.arrivalIcao &&
          other.departureTime == this.departureTime &&
          other.arrivalTime == this.arrivalTime &&
          other.totalDistanceNm == this.totalDistanceNm &&
          other.totalFuelGallons == this.totalFuelGallons &&
          other.maxAltitudeFt == this.maxAltitudeFt &&
          other.trackJson == this.trackJson &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class FlightLogsTableCompanion extends UpdateCompanion<FlightLogEntry> {
  final Value<int> id;
  final Value<int?> routeId;
  final Value<String?> departureIcao;
  final Value<String?> arrivalIcao;
  final Value<DateTime?> departureTime;
  final Value<DateTime?> arrivalTime;
  final Value<double?> totalDistanceNm;
  final Value<double?> totalFuelGallons;
  final Value<double?> maxAltitudeFt;
  final Value<String?> trackJson;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const FlightLogsTableCompanion({
    this.id = const Value.absent(),
    this.routeId = const Value.absent(),
    this.departureIcao = const Value.absent(),
    this.arrivalIcao = const Value.absent(),
    this.departureTime = const Value.absent(),
    this.arrivalTime = const Value.absent(),
    this.totalDistanceNm = const Value.absent(),
    this.totalFuelGallons = const Value.absent(),
    this.maxAltitudeFt = const Value.absent(),
    this.trackJson = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FlightLogsTableCompanion.insert({
    this.id = const Value.absent(),
    this.routeId = const Value.absent(),
    this.departureIcao = const Value.absent(),
    this.arrivalIcao = const Value.absent(),
    this.departureTime = const Value.absent(),
    this.arrivalTime = const Value.absent(),
    this.totalDistanceNm = const Value.absent(),
    this.totalFuelGallons = const Value.absent(),
    this.maxAltitudeFt = const Value.absent(),
    this.trackJson = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
  }) : createdAt = Value(createdAt);
  static Insertable<FlightLogEntry> custom({
    Expression<int>? id,
    Expression<int>? routeId,
    Expression<String>? departureIcao,
    Expression<String>? arrivalIcao,
    Expression<DateTime>? departureTime,
    Expression<DateTime>? arrivalTime,
    Expression<double>? totalDistanceNm,
    Expression<double>? totalFuelGallons,
    Expression<double>? maxAltitudeFt,
    Expression<String>? trackJson,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routeId != null) 'route_id': routeId,
      if (departureIcao != null) 'departure_icao': departureIcao,
      if (arrivalIcao != null) 'arrival_icao': arrivalIcao,
      if (departureTime != null) 'departure_time': departureTime,
      if (arrivalTime != null) 'arrival_time': arrivalTime,
      if (totalDistanceNm != null) 'total_distance_nm': totalDistanceNm,
      if (totalFuelGallons != null) 'total_fuel_gallons': totalFuelGallons,
      if (maxAltitudeFt != null) 'max_altitude_ft': maxAltitudeFt,
      if (trackJson != null) 'track_json': trackJson,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FlightLogsTableCompanion copyWith({
    Value<int>? id,
    Value<int?>? routeId,
    Value<String?>? departureIcao,
    Value<String?>? arrivalIcao,
    Value<DateTime?>? departureTime,
    Value<DateTime?>? arrivalTime,
    Value<double?>? totalDistanceNm,
    Value<double?>? totalFuelGallons,
    Value<double?>? maxAltitudeFt,
    Value<String?>? trackJson,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
  }) {
    return FlightLogsTableCompanion(
      id: id ?? this.id,
      routeId: routeId ?? this.routeId,
      departureIcao: departureIcao ?? this.departureIcao,
      arrivalIcao: arrivalIcao ?? this.arrivalIcao,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      totalDistanceNm: totalDistanceNm ?? this.totalDistanceNm,
      totalFuelGallons: totalFuelGallons ?? this.totalFuelGallons,
      maxAltitudeFt: maxAltitudeFt ?? this.maxAltitudeFt,
      trackJson: trackJson ?? this.trackJson,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (routeId.present) {
      map['route_id'] = Variable<int>(routeId.value);
    }
    if (departureIcao.present) {
      map['departure_icao'] = Variable<String>(departureIcao.value);
    }
    if (arrivalIcao.present) {
      map['arrival_icao'] = Variable<String>(arrivalIcao.value);
    }
    if (departureTime.present) {
      map['departure_time'] = Variable<DateTime>(departureTime.value);
    }
    if (arrivalTime.present) {
      map['arrival_time'] = Variable<DateTime>(arrivalTime.value);
    }
    if (totalDistanceNm.present) {
      map['total_distance_nm'] = Variable<double>(totalDistanceNm.value);
    }
    if (totalFuelGallons.present) {
      map['total_fuel_gallons'] = Variable<double>(totalFuelGallons.value);
    }
    if (maxAltitudeFt.present) {
      map['max_altitude_ft'] = Variable<double>(maxAltitudeFt.value);
    }
    if (trackJson.present) {
      map['track_json'] = Variable<String>(trackJson.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FlightLogsTableCompanion(')
          ..write('id: $id, ')
          ..write('routeId: $routeId, ')
          ..write('departureIcao: $departureIcao, ')
          ..write('arrivalIcao: $arrivalIcao, ')
          ..write('departureTime: $departureTime, ')
          ..write('arrivalTime: $arrivalTime, ')
          ..write('totalDistanceNm: $totalDistanceNm, ')
          ..write('totalFuelGallons: $totalFuelGallons, ')
          ..write('maxAltitudeFt: $maxAltitudeFt, ')
          ..write('trackJson: $trackJson, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AirportTableTable airportTable = $AirportTableTable(this);
  late final $RunwayTableTable runwayTable = $RunwayTableTable(this);
  late final $FrequencyTableTable frequencyTable = $FrequencyTableTable(this);
  late final $NavaidTableTable navaidTable = $NavaidTableTable(this);
  late final $SettingsTableTable settingsTable = $SettingsTableTable(this);
  late final $FavoritesTableTable favoritesTable = $FavoritesTableTable(this);
  late final $RoutesTableTable routesTable = $RoutesTableTable(this);
  late final $FlightLogsTableTable flightLogsTable = $FlightLogsTableTable(
    this,
  );
  late final AirportDao airportDao = AirportDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    airportTable,
    runwayTable,
    frequencyTable,
    navaidTable,
    settingsTable,
    favoritesTable,
    routesTable,
    flightLogsTable,
  ];
}

typedef $$AirportTableTableCreateCompanionBuilder =
    AirportTableCompanion Function({
      Value<int> id,
      Value<String?> icaoCode,
      Value<String?> faaCode,
      Value<String?> iataCode,
      required String name,
      required String type,
      required double latitude,
      required double longitude,
      Value<double?> elevationFt,
      required String countryCode,
      Value<String?> regionCode,
      Value<String?> municipality,
      Value<String?> timezone,
      Value<bool> hasTower,
      Value<double?> magneticVariation,
      required String dataSource,
      Value<String?> airacCycle,
      required DateTime updatedAt,
    });
typedef $$AirportTableTableUpdateCompanionBuilder =
    AirportTableCompanion Function({
      Value<int> id,
      Value<String?> icaoCode,
      Value<String?> faaCode,
      Value<String?> iataCode,
      Value<String> name,
      Value<String> type,
      Value<double> latitude,
      Value<double> longitude,
      Value<double?> elevationFt,
      Value<String> countryCode,
      Value<String?> regionCode,
      Value<String?> municipality,
      Value<String?> timezone,
      Value<bool> hasTower,
      Value<double?> magneticVariation,
      Value<String> dataSource,
      Value<String?> airacCycle,
      Value<DateTime> updatedAt,
    });

class $$AirportTableTableFilterComposer
    extends Composer<_$AppDatabase, $AirportTableTable> {
  $$AirportTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icaoCode => $composableBuilder(
    column: $table.icaoCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get faaCode => $composableBuilder(
    column: $table.faaCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iataCode => $composableBuilder(
    column: $table.iataCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get elevationFt => $composableBuilder(
    column: $table.elevationFt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get regionCode => $composableBuilder(
    column: $table.regionCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get municipality => $composableBuilder(
    column: $table.municipality,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasTower => $composableBuilder(
    column: $table.hasTower,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get magneticVariation => $composableBuilder(
    column: $table.magneticVariation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dataSource => $composableBuilder(
    column: $table.dataSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get airacCycle => $composableBuilder(
    column: $table.airacCycle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AirportTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AirportTableTable> {
  $$AirportTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icaoCode => $composableBuilder(
    column: $table.icaoCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get faaCode => $composableBuilder(
    column: $table.faaCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iataCode => $composableBuilder(
    column: $table.iataCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get elevationFt => $composableBuilder(
    column: $table.elevationFt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get regionCode => $composableBuilder(
    column: $table.regionCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get municipality => $composableBuilder(
    column: $table.municipality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasTower => $composableBuilder(
    column: $table.hasTower,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get magneticVariation => $composableBuilder(
    column: $table.magneticVariation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dataSource => $composableBuilder(
    column: $table.dataSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get airacCycle => $composableBuilder(
    column: $table.airacCycle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AirportTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AirportTableTable> {
  $$AirportTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get icaoCode =>
      $composableBuilder(column: $table.icaoCode, builder: (column) => column);

  GeneratedColumn<String> get faaCode =>
      $composableBuilder(column: $table.faaCode, builder: (column) => column);

  GeneratedColumn<String> get iataCode =>
      $composableBuilder(column: $table.iataCode, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get elevationFt => $composableBuilder(
    column: $table.elevationFt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get regionCode => $composableBuilder(
    column: $table.regionCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get municipality => $composableBuilder(
    column: $table.municipality,
    builder: (column) => column,
  );

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<bool> get hasTower =>
      $composableBuilder(column: $table.hasTower, builder: (column) => column);

  GeneratedColumn<double> get magneticVariation => $composableBuilder(
    column: $table.magneticVariation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dataSource => $composableBuilder(
    column: $table.dataSource,
    builder: (column) => column,
  );

  GeneratedColumn<String> get airacCycle => $composableBuilder(
    column: $table.airacCycle,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AirportTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AirportTableTable,
          AirportEntry,
          $$AirportTableTableFilterComposer,
          $$AirportTableTableOrderingComposer,
          $$AirportTableTableAnnotationComposer,
          $$AirportTableTableCreateCompanionBuilder,
          $$AirportTableTableUpdateCompanionBuilder,
          (
            AirportEntry,
            BaseReferences<_$AppDatabase, $AirportTableTable, AirportEntry>,
          ),
          AirportEntry,
          PrefetchHooks Function()
        > {
  $$AirportTableTableTableManager(_$AppDatabase db, $AirportTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AirportTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AirportTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AirportTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> icaoCode = const Value.absent(),
                Value<String?> faaCode = const Value.absent(),
                Value<String?> iataCode = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<double?> elevationFt = const Value.absent(),
                Value<String> countryCode = const Value.absent(),
                Value<String?> regionCode = const Value.absent(),
                Value<String?> municipality = const Value.absent(),
                Value<String?> timezone = const Value.absent(),
                Value<bool> hasTower = const Value.absent(),
                Value<double?> magneticVariation = const Value.absent(),
                Value<String> dataSource = const Value.absent(),
                Value<String?> airacCycle = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AirportTableCompanion(
                id: id,
                icaoCode: icaoCode,
                faaCode: faaCode,
                iataCode: iataCode,
                name: name,
                type: type,
                latitude: latitude,
                longitude: longitude,
                elevationFt: elevationFt,
                countryCode: countryCode,
                regionCode: regionCode,
                municipality: municipality,
                timezone: timezone,
                hasTower: hasTower,
                magneticVariation: magneticVariation,
                dataSource: dataSource,
                airacCycle: airacCycle,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> icaoCode = const Value.absent(),
                Value<String?> faaCode = const Value.absent(),
                Value<String?> iataCode = const Value.absent(),
                required String name,
                required String type,
                required double latitude,
                required double longitude,
                Value<double?> elevationFt = const Value.absent(),
                required String countryCode,
                Value<String?> regionCode = const Value.absent(),
                Value<String?> municipality = const Value.absent(),
                Value<String?> timezone = const Value.absent(),
                Value<bool> hasTower = const Value.absent(),
                Value<double?> magneticVariation = const Value.absent(),
                required String dataSource,
                Value<String?> airacCycle = const Value.absent(),
                required DateTime updatedAt,
              }) => AirportTableCompanion.insert(
                id: id,
                icaoCode: icaoCode,
                faaCode: faaCode,
                iataCode: iataCode,
                name: name,
                type: type,
                latitude: latitude,
                longitude: longitude,
                elevationFt: elevationFt,
                countryCode: countryCode,
                regionCode: regionCode,
                municipality: municipality,
                timezone: timezone,
                hasTower: hasTower,
                magneticVariation: magneticVariation,
                dataSource: dataSource,
                airacCycle: airacCycle,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AirportTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AirportTableTable,
      AirportEntry,
      $$AirportTableTableFilterComposer,
      $$AirportTableTableOrderingComposer,
      $$AirportTableTableAnnotationComposer,
      $$AirportTableTableCreateCompanionBuilder,
      $$AirportTableTableUpdateCompanionBuilder,
      (
        AirportEntry,
        BaseReferences<_$AppDatabase, $AirportTableTable, AirportEntry>,
      ),
      AirportEntry,
      PrefetchHooks Function()
    >;
typedef $$RunwayTableTableCreateCompanionBuilder =
    RunwayTableCompanion Function({
      Value<int> id,
      required int airportId,
      required String designator,
      Value<double?> lengthFt,
      Value<double?> widthFt,
      Value<String?> surface,
      Value<bool> lighted,
      Value<bool> closed,
      Value<String?> heDesignator,
      Value<double?> heLatitude,
      Value<double?> heLongitude,
      Value<double?> heElevationFt,
      Value<double?> heHeadingTrue,
      Value<String?> leDesignator,
      Value<double?> leLatitude,
      Value<double?> leLongitude,
      Value<double?> leElevationFt,
      Value<double?> leHeadingTrue,
    });
typedef $$RunwayTableTableUpdateCompanionBuilder =
    RunwayTableCompanion Function({
      Value<int> id,
      Value<int> airportId,
      Value<String> designator,
      Value<double?> lengthFt,
      Value<double?> widthFt,
      Value<String?> surface,
      Value<bool> lighted,
      Value<bool> closed,
      Value<String?> heDesignator,
      Value<double?> heLatitude,
      Value<double?> heLongitude,
      Value<double?> heElevationFt,
      Value<double?> heHeadingTrue,
      Value<String?> leDesignator,
      Value<double?> leLatitude,
      Value<double?> leLongitude,
      Value<double?> leElevationFt,
      Value<double?> leHeadingTrue,
    });

class $$RunwayTableTableFilterComposer
    extends Composer<_$AppDatabase, $RunwayTableTable> {
  $$RunwayTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get airportId => $composableBuilder(
    column: $table.airportId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get designator => $composableBuilder(
    column: $table.designator,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lengthFt => $composableBuilder(
    column: $table.lengthFt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get widthFt => $composableBuilder(
    column: $table.widthFt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get surface => $composableBuilder(
    column: $table.surface,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get lighted => $composableBuilder(
    column: $table.lighted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get closed => $composableBuilder(
    column: $table.closed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get heDesignator => $composableBuilder(
    column: $table.heDesignator,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heLatitude => $composableBuilder(
    column: $table.heLatitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heLongitude => $composableBuilder(
    column: $table.heLongitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heElevationFt => $composableBuilder(
    column: $table.heElevationFt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heHeadingTrue => $composableBuilder(
    column: $table.heHeadingTrue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get leDesignator => $composableBuilder(
    column: $table.leDesignator,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get leLatitude => $composableBuilder(
    column: $table.leLatitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get leLongitude => $composableBuilder(
    column: $table.leLongitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get leElevationFt => $composableBuilder(
    column: $table.leElevationFt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get leHeadingTrue => $composableBuilder(
    column: $table.leHeadingTrue,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RunwayTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RunwayTableTable> {
  $$RunwayTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get airportId => $composableBuilder(
    column: $table.airportId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get designator => $composableBuilder(
    column: $table.designator,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lengthFt => $composableBuilder(
    column: $table.lengthFt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get widthFt => $composableBuilder(
    column: $table.widthFt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get surface => $composableBuilder(
    column: $table.surface,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get lighted => $composableBuilder(
    column: $table.lighted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get closed => $composableBuilder(
    column: $table.closed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get heDesignator => $composableBuilder(
    column: $table.heDesignator,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heLatitude => $composableBuilder(
    column: $table.heLatitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heLongitude => $composableBuilder(
    column: $table.heLongitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heElevationFt => $composableBuilder(
    column: $table.heElevationFt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heHeadingTrue => $composableBuilder(
    column: $table.heHeadingTrue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get leDesignator => $composableBuilder(
    column: $table.leDesignator,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get leLatitude => $composableBuilder(
    column: $table.leLatitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get leLongitude => $composableBuilder(
    column: $table.leLongitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get leElevationFt => $composableBuilder(
    column: $table.leElevationFt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get leHeadingTrue => $composableBuilder(
    column: $table.leHeadingTrue,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RunwayTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RunwayTableTable> {
  $$RunwayTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get airportId =>
      $composableBuilder(column: $table.airportId, builder: (column) => column);

  GeneratedColumn<String> get designator => $composableBuilder(
    column: $table.designator,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lengthFt =>
      $composableBuilder(column: $table.lengthFt, builder: (column) => column);

  GeneratedColumn<double> get widthFt =>
      $composableBuilder(column: $table.widthFt, builder: (column) => column);

  GeneratedColumn<String> get surface =>
      $composableBuilder(column: $table.surface, builder: (column) => column);

  GeneratedColumn<bool> get lighted =>
      $composableBuilder(column: $table.lighted, builder: (column) => column);

  GeneratedColumn<bool> get closed =>
      $composableBuilder(column: $table.closed, builder: (column) => column);

  GeneratedColumn<String> get heDesignator => $composableBuilder(
    column: $table.heDesignator,
    builder: (column) => column,
  );

  GeneratedColumn<double> get heLatitude => $composableBuilder(
    column: $table.heLatitude,
    builder: (column) => column,
  );

  GeneratedColumn<double> get heLongitude => $composableBuilder(
    column: $table.heLongitude,
    builder: (column) => column,
  );

  GeneratedColumn<double> get heElevationFt => $composableBuilder(
    column: $table.heElevationFt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get heHeadingTrue => $composableBuilder(
    column: $table.heHeadingTrue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get leDesignator => $composableBuilder(
    column: $table.leDesignator,
    builder: (column) => column,
  );

  GeneratedColumn<double> get leLatitude => $composableBuilder(
    column: $table.leLatitude,
    builder: (column) => column,
  );

  GeneratedColumn<double> get leLongitude => $composableBuilder(
    column: $table.leLongitude,
    builder: (column) => column,
  );

  GeneratedColumn<double> get leElevationFt => $composableBuilder(
    column: $table.leElevationFt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get leHeadingTrue => $composableBuilder(
    column: $table.leHeadingTrue,
    builder: (column) => column,
  );
}

class $$RunwayTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RunwayTableTable,
          RunwayEntry,
          $$RunwayTableTableFilterComposer,
          $$RunwayTableTableOrderingComposer,
          $$RunwayTableTableAnnotationComposer,
          $$RunwayTableTableCreateCompanionBuilder,
          $$RunwayTableTableUpdateCompanionBuilder,
          (
            RunwayEntry,
            BaseReferences<_$AppDatabase, $RunwayTableTable, RunwayEntry>,
          ),
          RunwayEntry,
          PrefetchHooks Function()
        > {
  $$RunwayTableTableTableManager(_$AppDatabase db, $RunwayTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RunwayTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RunwayTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RunwayTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> airportId = const Value.absent(),
                Value<String> designator = const Value.absent(),
                Value<double?> lengthFt = const Value.absent(),
                Value<double?> widthFt = const Value.absent(),
                Value<String?> surface = const Value.absent(),
                Value<bool> lighted = const Value.absent(),
                Value<bool> closed = const Value.absent(),
                Value<String?> heDesignator = const Value.absent(),
                Value<double?> heLatitude = const Value.absent(),
                Value<double?> heLongitude = const Value.absent(),
                Value<double?> heElevationFt = const Value.absent(),
                Value<double?> heHeadingTrue = const Value.absent(),
                Value<String?> leDesignator = const Value.absent(),
                Value<double?> leLatitude = const Value.absent(),
                Value<double?> leLongitude = const Value.absent(),
                Value<double?> leElevationFt = const Value.absent(),
                Value<double?> leHeadingTrue = const Value.absent(),
              }) => RunwayTableCompanion(
                id: id,
                airportId: airportId,
                designator: designator,
                lengthFt: lengthFt,
                widthFt: widthFt,
                surface: surface,
                lighted: lighted,
                closed: closed,
                heDesignator: heDesignator,
                heLatitude: heLatitude,
                heLongitude: heLongitude,
                heElevationFt: heElevationFt,
                heHeadingTrue: heHeadingTrue,
                leDesignator: leDesignator,
                leLatitude: leLatitude,
                leLongitude: leLongitude,
                leElevationFt: leElevationFt,
                leHeadingTrue: leHeadingTrue,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int airportId,
                required String designator,
                Value<double?> lengthFt = const Value.absent(),
                Value<double?> widthFt = const Value.absent(),
                Value<String?> surface = const Value.absent(),
                Value<bool> lighted = const Value.absent(),
                Value<bool> closed = const Value.absent(),
                Value<String?> heDesignator = const Value.absent(),
                Value<double?> heLatitude = const Value.absent(),
                Value<double?> heLongitude = const Value.absent(),
                Value<double?> heElevationFt = const Value.absent(),
                Value<double?> heHeadingTrue = const Value.absent(),
                Value<String?> leDesignator = const Value.absent(),
                Value<double?> leLatitude = const Value.absent(),
                Value<double?> leLongitude = const Value.absent(),
                Value<double?> leElevationFt = const Value.absent(),
                Value<double?> leHeadingTrue = const Value.absent(),
              }) => RunwayTableCompanion.insert(
                id: id,
                airportId: airportId,
                designator: designator,
                lengthFt: lengthFt,
                widthFt: widthFt,
                surface: surface,
                lighted: lighted,
                closed: closed,
                heDesignator: heDesignator,
                heLatitude: heLatitude,
                heLongitude: heLongitude,
                heElevationFt: heElevationFt,
                heHeadingTrue: heHeadingTrue,
                leDesignator: leDesignator,
                leLatitude: leLatitude,
                leLongitude: leLongitude,
                leElevationFt: leElevationFt,
                leHeadingTrue: leHeadingTrue,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RunwayTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RunwayTableTable,
      RunwayEntry,
      $$RunwayTableTableFilterComposer,
      $$RunwayTableTableOrderingComposer,
      $$RunwayTableTableAnnotationComposer,
      $$RunwayTableTableCreateCompanionBuilder,
      $$RunwayTableTableUpdateCompanionBuilder,
      (
        RunwayEntry,
        BaseReferences<_$AppDatabase, $RunwayTableTable, RunwayEntry>,
      ),
      RunwayEntry,
      PrefetchHooks Function()
    >;
typedef $$FrequencyTableTableCreateCompanionBuilder =
    FrequencyTableCompanion Function({
      Value<int> id,
      required int airportId,
      required String type,
      Value<String?> description,
      required double frequencyMhz,
    });
typedef $$FrequencyTableTableUpdateCompanionBuilder =
    FrequencyTableCompanion Function({
      Value<int> id,
      Value<int> airportId,
      Value<String> type,
      Value<String?> description,
      Value<double> frequencyMhz,
    });

class $$FrequencyTableTableFilterComposer
    extends Composer<_$AppDatabase, $FrequencyTableTable> {
  $$FrequencyTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get airportId => $composableBuilder(
    column: $table.airportId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get frequencyMhz => $composableBuilder(
    column: $table.frequencyMhz,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FrequencyTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FrequencyTableTable> {
  $$FrequencyTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get airportId => $composableBuilder(
    column: $table.airportId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get frequencyMhz => $composableBuilder(
    column: $table.frequencyMhz,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FrequencyTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FrequencyTableTable> {
  $$FrequencyTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get airportId =>
      $composableBuilder(column: $table.airportId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get frequencyMhz => $composableBuilder(
    column: $table.frequencyMhz,
    builder: (column) => column,
  );
}

class $$FrequencyTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FrequencyTableTable,
          FrequencyEntry,
          $$FrequencyTableTableFilterComposer,
          $$FrequencyTableTableOrderingComposer,
          $$FrequencyTableTableAnnotationComposer,
          $$FrequencyTableTableCreateCompanionBuilder,
          $$FrequencyTableTableUpdateCompanionBuilder,
          (
            FrequencyEntry,
            BaseReferences<_$AppDatabase, $FrequencyTableTable, FrequencyEntry>,
          ),
          FrequencyEntry,
          PrefetchHooks Function()
        > {
  $$FrequencyTableTableTableManager(
    _$AppDatabase db,
    $FrequencyTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FrequencyTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FrequencyTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FrequencyTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> airportId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double> frequencyMhz = const Value.absent(),
              }) => FrequencyTableCompanion(
                id: id,
                airportId: airportId,
                type: type,
                description: description,
                frequencyMhz: frequencyMhz,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int airportId,
                required String type,
                Value<String?> description = const Value.absent(),
                required double frequencyMhz,
              }) => FrequencyTableCompanion.insert(
                id: id,
                airportId: airportId,
                type: type,
                description: description,
                frequencyMhz: frequencyMhz,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FrequencyTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FrequencyTableTable,
      FrequencyEntry,
      $$FrequencyTableTableFilterComposer,
      $$FrequencyTableTableOrderingComposer,
      $$FrequencyTableTableAnnotationComposer,
      $$FrequencyTableTableCreateCompanionBuilder,
      $$FrequencyTableTableUpdateCompanionBuilder,
      (
        FrequencyEntry,
        BaseReferences<_$AppDatabase, $FrequencyTableTable, FrequencyEntry>,
      ),
      FrequencyEntry,
      PrefetchHooks Function()
    >;
typedef $$NavaidTableTableCreateCompanionBuilder =
    NavaidTableCompanion Function({
      Value<int> id,
      required String ident,
      required String name,
      required String type,
      required double latitude,
      required double longitude,
      Value<double?> elevationFt,
      Value<double?> frequency,
      Value<double?> magneticVariation,
      Value<double?> rangeNm,
    });
typedef $$NavaidTableTableUpdateCompanionBuilder =
    NavaidTableCompanion Function({
      Value<int> id,
      Value<String> ident,
      Value<String> name,
      Value<String> type,
      Value<double> latitude,
      Value<double> longitude,
      Value<double?> elevationFt,
      Value<double?> frequency,
      Value<double?> magneticVariation,
      Value<double?> rangeNm,
    });

class $$NavaidTableTableFilterComposer
    extends Composer<_$AppDatabase, $NavaidTableTable> {
  $$NavaidTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ident => $composableBuilder(
    column: $table.ident,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get elevationFt => $composableBuilder(
    column: $table.elevationFt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get magneticVariation => $composableBuilder(
    column: $table.magneticVariation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rangeNm => $composableBuilder(
    column: $table.rangeNm,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NavaidTableTableOrderingComposer
    extends Composer<_$AppDatabase, $NavaidTableTable> {
  $$NavaidTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ident => $composableBuilder(
    column: $table.ident,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get elevationFt => $composableBuilder(
    column: $table.elevationFt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get magneticVariation => $composableBuilder(
    column: $table.magneticVariation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rangeNm => $composableBuilder(
    column: $table.rangeNm,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NavaidTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $NavaidTableTable> {
  $$NavaidTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ident =>
      $composableBuilder(column: $table.ident, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get elevationFt => $composableBuilder(
    column: $table.elevationFt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<double> get magneticVariation => $composableBuilder(
    column: $table.magneticVariation,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rangeNm =>
      $composableBuilder(column: $table.rangeNm, builder: (column) => column);
}

class $$NavaidTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NavaidTableTable,
          NavaidEntry,
          $$NavaidTableTableFilterComposer,
          $$NavaidTableTableOrderingComposer,
          $$NavaidTableTableAnnotationComposer,
          $$NavaidTableTableCreateCompanionBuilder,
          $$NavaidTableTableUpdateCompanionBuilder,
          (
            NavaidEntry,
            BaseReferences<_$AppDatabase, $NavaidTableTable, NavaidEntry>,
          ),
          NavaidEntry,
          PrefetchHooks Function()
        > {
  $$NavaidTableTableTableManager(_$AppDatabase db, $NavaidTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NavaidTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NavaidTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NavaidTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> ident = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<double?> elevationFt = const Value.absent(),
                Value<double?> frequency = const Value.absent(),
                Value<double?> magneticVariation = const Value.absent(),
                Value<double?> rangeNm = const Value.absent(),
              }) => NavaidTableCompanion(
                id: id,
                ident: ident,
                name: name,
                type: type,
                latitude: latitude,
                longitude: longitude,
                elevationFt: elevationFt,
                frequency: frequency,
                magneticVariation: magneticVariation,
                rangeNm: rangeNm,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String ident,
                required String name,
                required String type,
                required double latitude,
                required double longitude,
                Value<double?> elevationFt = const Value.absent(),
                Value<double?> frequency = const Value.absent(),
                Value<double?> magneticVariation = const Value.absent(),
                Value<double?> rangeNm = const Value.absent(),
              }) => NavaidTableCompanion.insert(
                id: id,
                ident: ident,
                name: name,
                type: type,
                latitude: latitude,
                longitude: longitude,
                elevationFt: elevationFt,
                frequency: frequency,
                magneticVariation: magneticVariation,
                rangeNm: rangeNm,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NavaidTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NavaidTableTable,
      NavaidEntry,
      $$NavaidTableTableFilterComposer,
      $$NavaidTableTableOrderingComposer,
      $$NavaidTableTableAnnotationComposer,
      $$NavaidTableTableCreateCompanionBuilder,
      $$NavaidTableTableUpdateCompanionBuilder,
      (
        NavaidEntry,
        BaseReferences<_$AppDatabase, $NavaidTableTable, NavaidEntry>,
      ),
      NavaidEntry,
      PrefetchHooks Function()
    >;
typedef $$SettingsTableTableCreateCompanionBuilder =
    SettingsTableCompanion Function({
      required String key,
      required String value,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SettingsTableTableUpdateCompanionBuilder =
    SettingsTableCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$SettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTableTable,
          SettingEntry,
          $$SettingsTableTableFilterComposer,
          $$SettingsTableTableOrderingComposer,
          $$SettingsTableTableAnnotationComposer,
          $$SettingsTableTableCreateCompanionBuilder,
          $$SettingsTableTableUpdateCompanionBuilder,
          (
            SettingEntry,
            BaseReferences<_$AppDatabase, $SettingsTableTable, SettingEntry>,
          ),
          SettingEntry,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableTableManager(_$AppDatabase db, $SettingsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsTableCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SettingsTableCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTableTable,
      SettingEntry,
      $$SettingsTableTableFilterComposer,
      $$SettingsTableTableOrderingComposer,
      $$SettingsTableTableAnnotationComposer,
      $$SettingsTableTableCreateCompanionBuilder,
      $$SettingsTableTableUpdateCompanionBuilder,
      (
        SettingEntry,
        BaseReferences<_$AppDatabase, $SettingsTableTable, SettingEntry>,
      ),
      SettingEntry,
      PrefetchHooks Function()
    >;
typedef $$FavoritesTableTableCreateCompanionBuilder =
    FavoritesTableCompanion Function({
      Value<int> id,
      required String type,
      required int referenceId,
      Value<String?> label,
      Value<int> sortOrder,
      required DateTime createdAt,
    });
typedef $$FavoritesTableTableUpdateCompanionBuilder =
    FavoritesTableCompanion Function({
      Value<int> id,
      Value<String> type,
      Value<int> referenceId,
      Value<String?> label,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
    });

class $$FavoritesTableTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritesTableTable> {
  $$FavoritesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoritesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritesTableTable> {
  $$FavoritesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoritesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritesTableTable> {
  $$FavoritesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$FavoritesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoritesTableTable,
          FavoriteEntry,
          $$FavoritesTableTableFilterComposer,
          $$FavoritesTableTableOrderingComposer,
          $$FavoritesTableTableAnnotationComposer,
          $$FavoritesTableTableCreateCompanionBuilder,
          $$FavoritesTableTableUpdateCompanionBuilder,
          (
            FavoriteEntry,
            BaseReferences<_$AppDatabase, $FavoritesTableTable, FavoriteEntry>,
          ),
          FavoriteEntry,
          PrefetchHooks Function()
        > {
  $$FavoritesTableTableTableManager(
    _$AppDatabase db,
    $FavoritesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> referenceId = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FavoritesTableCompanion(
                id: id,
                type: type,
                referenceId: referenceId,
                label: label,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String type,
                required int referenceId,
                Value<String?> label = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                required DateTime createdAt,
              }) => FavoritesTableCompanion.insert(
                id: id,
                type: type,
                referenceId: referenceId,
                label: label,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoritesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoritesTableTable,
      FavoriteEntry,
      $$FavoritesTableTableFilterComposer,
      $$FavoritesTableTableOrderingComposer,
      $$FavoritesTableTableAnnotationComposer,
      $$FavoritesTableTableCreateCompanionBuilder,
      $$FavoritesTableTableUpdateCompanionBuilder,
      (
        FavoriteEntry,
        BaseReferences<_$AppDatabase, $FavoritesTableTable, FavoriteEntry>,
      ),
      FavoriteEntry,
      PrefetchHooks Function()
    >;
typedef $$RoutesTableTableCreateCompanionBuilder =
    RoutesTableCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      required String waypointsJson,
      Value<double?> totalDistanceNm,
      Value<int?> totalTimeSeconds,
      Value<String?> aircraftProfileId,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$RoutesTableTableUpdateCompanionBuilder =
    RoutesTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<String> waypointsJson,
      Value<double?> totalDistanceNm,
      Value<int?> totalTimeSeconds,
      Value<String?> aircraftProfileId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$RoutesTableTableFilterComposer
    extends Composer<_$AppDatabase, $RoutesTableTable> {
  $$RoutesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get waypointsJson => $composableBuilder(
    column: $table.waypointsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalDistanceNm => $composableBuilder(
    column: $table.totalDistanceNm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalTimeSeconds => $composableBuilder(
    column: $table.totalTimeSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aircraftProfileId => $composableBuilder(
    column: $table.aircraftProfileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RoutesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutesTableTable> {
  $$RoutesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get waypointsJson => $composableBuilder(
    column: $table.waypointsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalDistanceNm => $composableBuilder(
    column: $table.totalDistanceNm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalTimeSeconds => $composableBuilder(
    column: $table.totalTimeSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aircraftProfileId => $composableBuilder(
    column: $table.aircraftProfileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoutesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutesTableTable> {
  $$RoutesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get waypointsJson => $composableBuilder(
    column: $table.waypointsJson,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalDistanceNm => $composableBuilder(
    column: $table.totalDistanceNm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalTimeSeconds => $composableBuilder(
    column: $table.totalTimeSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get aircraftProfileId => $composableBuilder(
    column: $table.aircraftProfileId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$RoutesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutesTableTable,
          RouteEntry,
          $$RoutesTableTableFilterComposer,
          $$RoutesTableTableOrderingComposer,
          $$RoutesTableTableAnnotationComposer,
          $$RoutesTableTableCreateCompanionBuilder,
          $$RoutesTableTableUpdateCompanionBuilder,
          (
            RouteEntry,
            BaseReferences<_$AppDatabase, $RoutesTableTable, RouteEntry>,
          ),
          RouteEntry,
          PrefetchHooks Function()
        > {
  $$RoutesTableTableTableManager(_$AppDatabase db, $RoutesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> waypointsJson = const Value.absent(),
                Value<double?> totalDistanceNm = const Value.absent(),
                Value<int?> totalTimeSeconds = const Value.absent(),
                Value<String?> aircraftProfileId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => RoutesTableCompanion(
                id: id,
                name: name,
                description: description,
                waypointsJson: waypointsJson,
                totalDistanceNm: totalDistanceNm,
                totalTimeSeconds: totalTimeSeconds,
                aircraftProfileId: aircraftProfileId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                required String waypointsJson,
                Value<double?> totalDistanceNm = const Value.absent(),
                Value<int?> totalTimeSeconds = const Value.absent(),
                Value<String?> aircraftProfileId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => RoutesTableCompanion.insert(
                id: id,
                name: name,
                description: description,
                waypointsJson: waypointsJson,
                totalDistanceNm: totalDistanceNm,
                totalTimeSeconds: totalTimeSeconds,
                aircraftProfileId: aircraftProfileId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RoutesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutesTableTable,
      RouteEntry,
      $$RoutesTableTableFilterComposer,
      $$RoutesTableTableOrderingComposer,
      $$RoutesTableTableAnnotationComposer,
      $$RoutesTableTableCreateCompanionBuilder,
      $$RoutesTableTableUpdateCompanionBuilder,
      (
        RouteEntry,
        BaseReferences<_$AppDatabase, $RoutesTableTable, RouteEntry>,
      ),
      RouteEntry,
      PrefetchHooks Function()
    >;
typedef $$FlightLogsTableTableCreateCompanionBuilder =
    FlightLogsTableCompanion Function({
      Value<int> id,
      Value<int?> routeId,
      Value<String?> departureIcao,
      Value<String?> arrivalIcao,
      Value<DateTime?> departureTime,
      Value<DateTime?> arrivalTime,
      Value<double?> totalDistanceNm,
      Value<double?> totalFuelGallons,
      Value<double?> maxAltitudeFt,
      Value<String?> trackJson,
      Value<String?> notes,
      required DateTime createdAt,
    });
typedef $$FlightLogsTableTableUpdateCompanionBuilder =
    FlightLogsTableCompanion Function({
      Value<int> id,
      Value<int?> routeId,
      Value<String?> departureIcao,
      Value<String?> arrivalIcao,
      Value<DateTime?> departureTime,
      Value<DateTime?> arrivalTime,
      Value<double?> totalDistanceNm,
      Value<double?> totalFuelGallons,
      Value<double?> maxAltitudeFt,
      Value<String?> trackJson,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });

class $$FlightLogsTableTableFilterComposer
    extends Composer<_$AppDatabase, $FlightLogsTableTable> {
  $$FlightLogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get routeId => $composableBuilder(
    column: $table.routeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get departureIcao => $composableBuilder(
    column: $table.departureIcao,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get arrivalIcao => $composableBuilder(
    column: $table.arrivalIcao,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get departureTime => $composableBuilder(
    column: $table.departureTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get arrivalTime => $composableBuilder(
    column: $table.arrivalTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalDistanceNm => $composableBuilder(
    column: $table.totalDistanceNm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalFuelGallons => $composableBuilder(
    column: $table.totalFuelGallons,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxAltitudeFt => $composableBuilder(
    column: $table.maxAltitudeFt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trackJson => $composableBuilder(
    column: $table.trackJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FlightLogsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FlightLogsTableTable> {
  $$FlightLogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get routeId => $composableBuilder(
    column: $table.routeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get departureIcao => $composableBuilder(
    column: $table.departureIcao,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get arrivalIcao => $composableBuilder(
    column: $table.arrivalIcao,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get departureTime => $composableBuilder(
    column: $table.departureTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get arrivalTime => $composableBuilder(
    column: $table.arrivalTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalDistanceNm => $composableBuilder(
    column: $table.totalDistanceNm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalFuelGallons => $composableBuilder(
    column: $table.totalFuelGallons,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxAltitudeFt => $composableBuilder(
    column: $table.maxAltitudeFt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trackJson => $composableBuilder(
    column: $table.trackJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FlightLogsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FlightLogsTableTable> {
  $$FlightLogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get routeId =>
      $composableBuilder(column: $table.routeId, builder: (column) => column);

  GeneratedColumn<String> get departureIcao => $composableBuilder(
    column: $table.departureIcao,
    builder: (column) => column,
  );

  GeneratedColumn<String> get arrivalIcao => $composableBuilder(
    column: $table.arrivalIcao,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get departureTime => $composableBuilder(
    column: $table.departureTime,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get arrivalTime => $composableBuilder(
    column: $table.arrivalTime,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalDistanceNm => $composableBuilder(
    column: $table.totalDistanceNm,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalFuelGallons => $composableBuilder(
    column: $table.totalFuelGallons,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxAltitudeFt => $composableBuilder(
    column: $table.maxAltitudeFt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get trackJson =>
      $composableBuilder(column: $table.trackJson, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$FlightLogsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FlightLogsTableTable,
          FlightLogEntry,
          $$FlightLogsTableTableFilterComposer,
          $$FlightLogsTableTableOrderingComposer,
          $$FlightLogsTableTableAnnotationComposer,
          $$FlightLogsTableTableCreateCompanionBuilder,
          $$FlightLogsTableTableUpdateCompanionBuilder,
          (
            FlightLogEntry,
            BaseReferences<
              _$AppDatabase,
              $FlightLogsTableTable,
              FlightLogEntry
            >,
          ),
          FlightLogEntry,
          PrefetchHooks Function()
        > {
  $$FlightLogsTableTableTableManager(
    _$AppDatabase db,
    $FlightLogsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FlightLogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FlightLogsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FlightLogsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> routeId = const Value.absent(),
                Value<String?> departureIcao = const Value.absent(),
                Value<String?> arrivalIcao = const Value.absent(),
                Value<DateTime?> departureTime = const Value.absent(),
                Value<DateTime?> arrivalTime = const Value.absent(),
                Value<double?> totalDistanceNm = const Value.absent(),
                Value<double?> totalFuelGallons = const Value.absent(),
                Value<double?> maxAltitudeFt = const Value.absent(),
                Value<String?> trackJson = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FlightLogsTableCompanion(
                id: id,
                routeId: routeId,
                departureIcao: departureIcao,
                arrivalIcao: arrivalIcao,
                departureTime: departureTime,
                arrivalTime: arrivalTime,
                totalDistanceNm: totalDistanceNm,
                totalFuelGallons: totalFuelGallons,
                maxAltitudeFt: maxAltitudeFt,
                trackJson: trackJson,
                notes: notes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> routeId = const Value.absent(),
                Value<String?> departureIcao = const Value.absent(),
                Value<String?> arrivalIcao = const Value.absent(),
                Value<DateTime?> departureTime = const Value.absent(),
                Value<DateTime?> arrivalTime = const Value.absent(),
                Value<double?> totalDistanceNm = const Value.absent(),
                Value<double?> totalFuelGallons = const Value.absent(),
                Value<double?> maxAltitudeFt = const Value.absent(),
                Value<String?> trackJson = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
              }) => FlightLogsTableCompanion.insert(
                id: id,
                routeId: routeId,
                departureIcao: departureIcao,
                arrivalIcao: arrivalIcao,
                departureTime: departureTime,
                arrivalTime: arrivalTime,
                totalDistanceNm: totalDistanceNm,
                totalFuelGallons: totalFuelGallons,
                maxAltitudeFt: maxAltitudeFt,
                trackJson: trackJson,
                notes: notes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FlightLogsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FlightLogsTableTable,
      FlightLogEntry,
      $$FlightLogsTableTableFilterComposer,
      $$FlightLogsTableTableOrderingComposer,
      $$FlightLogsTableTableAnnotationComposer,
      $$FlightLogsTableTableCreateCompanionBuilder,
      $$FlightLogsTableTableUpdateCompanionBuilder,
      (
        FlightLogEntry,
        BaseReferences<_$AppDatabase, $FlightLogsTableTable, FlightLogEntry>,
      ),
      FlightLogEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AirportTableTableTableManager get airportTable =>
      $$AirportTableTableTableManager(_db, _db.airportTable);
  $$RunwayTableTableTableManager get runwayTable =>
      $$RunwayTableTableTableManager(_db, _db.runwayTable);
  $$FrequencyTableTableTableManager get frequencyTable =>
      $$FrequencyTableTableTableManager(_db, _db.frequencyTable);
  $$NavaidTableTableTableManager get navaidTable =>
      $$NavaidTableTableTableManager(_db, _db.navaidTable);
  $$SettingsTableTableTableManager get settingsTable =>
      $$SettingsTableTableTableManager(_db, _db.settingsTable);
  $$FavoritesTableTableTableManager get favoritesTable =>
      $$FavoritesTableTableTableManager(_db, _db.favoritesTable);
  $$RoutesTableTableTableManager get routesTable =>
      $$RoutesTableTableTableManager(_db, _db.routesTable);
  $$FlightLogsTableTableTableManager get flightLogsTable =>
      $$FlightLogsTableTableTableManager(_db, _db.flightLogsTable);
}
