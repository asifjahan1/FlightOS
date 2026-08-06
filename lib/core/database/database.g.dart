// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AirportsTable extends Airports
    with TableInfo<$AirportsTable, AirportData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AirportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _icaoMeta = const VerificationMeta('icao');
  @override
  late final GeneratedColumn<String> icao = GeneratedColumn<String>(
    'icao',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'UNIQUE NOT NULL',
  );
  static const VerificationMeta _iataMeta = const VerificationMeta('iata');
  @override
  late final GeneratedColumn<String> iata = GeneratedColumn<String>(
    'iata',
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
  static const VerificationMeta _elevationMeta = const VerificationMeta(
    'elevation',
  );
  @override
  late final GeneratedColumn<double> elevation = GeneratedColumn<double>(
    'elevation',
    aliasedName,
    false,
    type: DriftSqlType.double,
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
  @override
  List<GeneratedColumn> get $columns => [
    icao,
    iata,
    name,
    latitude,
    longitude,
    elevation,
    type,
    municipality,
    countryCode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'airports';
  @override
  VerificationContext validateIntegrity(
    Insertable<AirportData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('icao')) {
      context.handle(
        _icaoMeta,
        icao.isAcceptableOrUnknown(data['icao']!, _icaoMeta),
      );
    } else if (isInserting) {
      context.missing(_icaoMeta);
    }
    if (data.containsKey('iata')) {
      context.handle(
        _iataMeta,
        iata.isAcceptableOrUnknown(data['iata']!, _iataMeta),
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
    if (data.containsKey('elevation')) {
      context.handle(
        _elevationMeta,
        elevation.isAcceptableOrUnknown(data['elevation']!, _elevationMeta),
      );
    } else if (isInserting) {
      context.missing(_elevationMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {icao};
  @override
  AirportData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AirportData(
      icao: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icao'],
      )!,
      iata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}iata'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      elevation: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}elevation'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      municipality: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}municipality'],
      ),
      countryCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country_code'],
      )!,
    );
  }

  @override
  $AirportsTable createAlias(String alias) {
    return $AirportsTable(attachedDatabase, alias);
  }
}

class AirportData extends DataClass implements Insertable<AirportData> {
  final String icao;
  final String? iata;
  final String name;
  final double latitude;
  final double longitude;
  final double elevation;
  final String type;
  final String? municipality;
  final String countryCode;
  const AirportData({
    required this.icao,
    this.iata,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.elevation,
    required this.type,
    this.municipality,
    required this.countryCode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['icao'] = Variable<String>(icao);
    if (!nullToAbsent || iata != null) {
      map['iata'] = Variable<String>(iata);
    }
    map['name'] = Variable<String>(name);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['elevation'] = Variable<double>(elevation);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || municipality != null) {
      map['municipality'] = Variable<String>(municipality);
    }
    map['country_code'] = Variable<String>(countryCode);
    return map;
  }

  AirportsCompanion toCompanion(bool nullToAbsent) {
    return AirportsCompanion(
      icao: Value(icao),
      iata: iata == null && nullToAbsent ? const Value.absent() : Value(iata),
      name: Value(name),
      latitude: Value(latitude),
      longitude: Value(longitude),
      elevation: Value(elevation),
      type: Value(type),
      municipality: municipality == null && nullToAbsent
          ? const Value.absent()
          : Value(municipality),
      countryCode: Value(countryCode),
    );
  }

  factory AirportData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AirportData(
      icao: serializer.fromJson<String>(json['icao']),
      iata: serializer.fromJson<String?>(json['iata']),
      name: serializer.fromJson<String>(json['name']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      elevation: serializer.fromJson<double>(json['elevation']),
      type: serializer.fromJson<String>(json['type']),
      municipality: serializer.fromJson<String?>(json['municipality']),
      countryCode: serializer.fromJson<String>(json['countryCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'icao': serializer.toJson<String>(icao),
      'iata': serializer.toJson<String?>(iata),
      'name': serializer.toJson<String>(name),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'elevation': serializer.toJson<double>(elevation),
      'type': serializer.toJson<String>(type),
      'municipality': serializer.toJson<String?>(municipality),
      'countryCode': serializer.toJson<String>(countryCode),
    };
  }

  AirportData copyWith({
    String? icao,
    Value<String?> iata = const Value.absent(),
    String? name,
    double? latitude,
    double? longitude,
    double? elevation,
    String? type,
    Value<String?> municipality = const Value.absent(),
    String? countryCode,
  }) => AirportData(
    icao: icao ?? this.icao,
    iata: iata.present ? iata.value : this.iata,
    name: name ?? this.name,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    elevation: elevation ?? this.elevation,
    type: type ?? this.type,
    municipality: municipality.present ? municipality.value : this.municipality,
    countryCode: countryCode ?? this.countryCode,
  );
  AirportData copyWithCompanion(AirportsCompanion data) {
    return AirportData(
      icao: data.icao.present ? data.icao.value : this.icao,
      iata: data.iata.present ? data.iata.value : this.iata,
      name: data.name.present ? data.name.value : this.name,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      elevation: data.elevation.present ? data.elevation.value : this.elevation,
      type: data.type.present ? data.type.value : this.type,
      municipality: data.municipality.present
          ? data.municipality.value
          : this.municipality,
      countryCode: data.countryCode.present
          ? data.countryCode.value
          : this.countryCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AirportData(')
          ..write('icao: $icao, ')
          ..write('iata: $iata, ')
          ..write('name: $name, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('elevation: $elevation, ')
          ..write('type: $type, ')
          ..write('municipality: $municipality, ')
          ..write('countryCode: $countryCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    icao,
    iata,
    name,
    latitude,
    longitude,
    elevation,
    type,
    municipality,
    countryCode,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AirportData &&
          other.icao == this.icao &&
          other.iata == this.iata &&
          other.name == this.name &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.elevation == this.elevation &&
          other.type == this.type &&
          other.municipality == this.municipality &&
          other.countryCode == this.countryCode);
}

class AirportsCompanion extends UpdateCompanion<AirportData> {
  final Value<String> icao;
  final Value<String?> iata;
  final Value<String> name;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<double> elevation;
  final Value<String> type;
  final Value<String?> municipality;
  final Value<String> countryCode;
  final Value<int> rowid;
  const AirportsCompanion({
    this.icao = const Value.absent(),
    this.iata = const Value.absent(),
    this.name = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.elevation = const Value.absent(),
    this.type = const Value.absent(),
    this.municipality = const Value.absent(),
    this.countryCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AirportsCompanion.insert({
    required String icao,
    this.iata = const Value.absent(),
    required String name,
    required double latitude,
    required double longitude,
    required double elevation,
    required String type,
    this.municipality = const Value.absent(),
    required String countryCode,
    this.rowid = const Value.absent(),
  }) : icao = Value(icao),
       name = Value(name),
       latitude = Value(latitude),
       longitude = Value(longitude),
       elevation = Value(elevation),
       type = Value(type),
       countryCode = Value(countryCode);
  static Insertable<AirportData> custom({
    Expression<String>? icao,
    Expression<String>? iata,
    Expression<String>? name,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? elevation,
    Expression<String>? type,
    Expression<String>? municipality,
    Expression<String>? countryCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (icao != null) 'icao': icao,
      if (iata != null) 'iata': iata,
      if (name != null) 'name': name,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (elevation != null) 'elevation': elevation,
      if (type != null) 'type': type,
      if (municipality != null) 'municipality': municipality,
      if (countryCode != null) 'country_code': countryCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AirportsCompanion copyWith({
    Value<String>? icao,
    Value<String?>? iata,
    Value<String>? name,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<double>? elevation,
    Value<String>? type,
    Value<String?>? municipality,
    Value<String>? countryCode,
    Value<int>? rowid,
  }) {
    return AirportsCompanion(
      icao: icao ?? this.icao,
      iata: iata ?? this.iata,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      elevation: elevation ?? this.elevation,
      type: type ?? this.type,
      municipality: municipality ?? this.municipality,
      countryCode: countryCode ?? this.countryCode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (icao.present) {
      map['icao'] = Variable<String>(icao.value);
    }
    if (iata.present) {
      map['iata'] = Variable<String>(iata.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (elevation.present) {
      map['elevation'] = Variable<double>(elevation.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (municipality.present) {
      map['municipality'] = Variable<String>(municipality.value);
    }
    if (countryCode.present) {
      map['country_code'] = Variable<String>(countryCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AirportsCompanion(')
          ..write('icao: $icao, ')
          ..write('iata: $iata, ')
          ..write('name: $name, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('elevation: $elevation, ')
          ..write('type: $type, ')
          ..write('municipality: $municipality, ')
          ..write('countryCode: $countryCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RunwaysTable extends Runways with TableInfo<$RunwaysTable, RunwayData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RunwaysTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _airportIcaoMeta = const VerificationMeta(
    'airportIcao',
  );
  @override
  late final GeneratedColumn<String> airportIcao = GeneratedColumn<String>(
    'airport_icao',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lengthMeta = const VerificationMeta('length');
  @override
  late final GeneratedColumn<double> length = GeneratedColumn<double>(
    'length',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<double> width = GeneratedColumn<double>(
    'width',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
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
  static const VerificationMeta _identMeta = const VerificationMeta('ident');
  @override
  late final GeneratedColumn<String> ident = GeneratedColumn<String>(
    'ident',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    airportIcao,
    length,
    width,
    surface,
    ident,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'runways';
  @override
  VerificationContext validateIntegrity(
    Insertable<RunwayData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('airport_icao')) {
      context.handle(
        _airportIcaoMeta,
        airportIcao.isAcceptableOrUnknown(
          data['airport_icao']!,
          _airportIcaoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_airportIcaoMeta);
    }
    if (data.containsKey('length')) {
      context.handle(
        _lengthMeta,
        length.isAcceptableOrUnknown(data['length']!, _lengthMeta),
      );
    } else if (isInserting) {
      context.missing(_lengthMeta);
    }
    if (data.containsKey('width')) {
      context.handle(
        _widthMeta,
        width.isAcceptableOrUnknown(data['width']!, _widthMeta),
      );
    } else if (isInserting) {
      context.missing(_widthMeta);
    }
    if (data.containsKey('surface')) {
      context.handle(
        _surfaceMeta,
        surface.isAcceptableOrUnknown(data['surface']!, _surfaceMeta),
      );
    }
    if (data.containsKey('ident')) {
      context.handle(
        _identMeta,
        ident.isAcceptableOrUnknown(data['ident']!, _identMeta),
      );
    } else if (isInserting) {
      context.missing(_identMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RunwayData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RunwayData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      airportIcao: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}airport_icao'],
      )!,
      length: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}length'],
      )!,
      width: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}width'],
      )!,
      surface: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}surface'],
      ),
      ident: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ident'],
      )!,
    );
  }

  @override
  $RunwaysTable createAlias(String alias) {
    return $RunwaysTable(attachedDatabase, alias);
  }
}

class RunwayData extends DataClass implements Insertable<RunwayData> {
  final int id;
  final String airportIcao;
  final double length;
  final double width;
  final String? surface;
  final String ident;
  const RunwayData({
    required this.id,
    required this.airportIcao,
    required this.length,
    required this.width,
    this.surface,
    required this.ident,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['airport_icao'] = Variable<String>(airportIcao);
    map['length'] = Variable<double>(length);
    map['width'] = Variable<double>(width);
    if (!nullToAbsent || surface != null) {
      map['surface'] = Variable<String>(surface);
    }
    map['ident'] = Variable<String>(ident);
    return map;
  }

  RunwaysCompanion toCompanion(bool nullToAbsent) {
    return RunwaysCompanion(
      id: Value(id),
      airportIcao: Value(airportIcao),
      length: Value(length),
      width: Value(width),
      surface: surface == null && nullToAbsent
          ? const Value.absent()
          : Value(surface),
      ident: Value(ident),
    );
  }

  factory RunwayData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RunwayData(
      id: serializer.fromJson<int>(json['id']),
      airportIcao: serializer.fromJson<String>(json['airportIcao']),
      length: serializer.fromJson<double>(json['length']),
      width: serializer.fromJson<double>(json['width']),
      surface: serializer.fromJson<String?>(json['surface']),
      ident: serializer.fromJson<String>(json['ident']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'airportIcao': serializer.toJson<String>(airportIcao),
      'length': serializer.toJson<double>(length),
      'width': serializer.toJson<double>(width),
      'surface': serializer.toJson<String?>(surface),
      'ident': serializer.toJson<String>(ident),
    };
  }

  RunwayData copyWith({
    int? id,
    String? airportIcao,
    double? length,
    double? width,
    Value<String?> surface = const Value.absent(),
    String? ident,
  }) => RunwayData(
    id: id ?? this.id,
    airportIcao: airportIcao ?? this.airportIcao,
    length: length ?? this.length,
    width: width ?? this.width,
    surface: surface.present ? surface.value : this.surface,
    ident: ident ?? this.ident,
  );
  RunwayData copyWithCompanion(RunwaysCompanion data) {
    return RunwayData(
      id: data.id.present ? data.id.value : this.id,
      airportIcao: data.airportIcao.present
          ? data.airportIcao.value
          : this.airportIcao,
      length: data.length.present ? data.length.value : this.length,
      width: data.width.present ? data.width.value : this.width,
      surface: data.surface.present ? data.surface.value : this.surface,
      ident: data.ident.present ? data.ident.value : this.ident,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RunwayData(')
          ..write('id: $id, ')
          ..write('airportIcao: $airportIcao, ')
          ..write('length: $length, ')
          ..write('width: $width, ')
          ..write('surface: $surface, ')
          ..write('ident: $ident')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, airportIcao, length, width, surface, ident);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RunwayData &&
          other.id == this.id &&
          other.airportIcao == this.airportIcao &&
          other.length == this.length &&
          other.width == this.width &&
          other.surface == this.surface &&
          other.ident == this.ident);
}

class RunwaysCompanion extends UpdateCompanion<RunwayData> {
  final Value<int> id;
  final Value<String> airportIcao;
  final Value<double> length;
  final Value<double> width;
  final Value<String?> surface;
  final Value<String> ident;
  const RunwaysCompanion({
    this.id = const Value.absent(),
    this.airportIcao = const Value.absent(),
    this.length = const Value.absent(),
    this.width = const Value.absent(),
    this.surface = const Value.absent(),
    this.ident = const Value.absent(),
  });
  RunwaysCompanion.insert({
    this.id = const Value.absent(),
    required String airportIcao,
    required double length,
    required double width,
    this.surface = const Value.absent(),
    required String ident,
  }) : airportIcao = Value(airportIcao),
       length = Value(length),
       width = Value(width),
       ident = Value(ident);
  static Insertable<RunwayData> custom({
    Expression<int>? id,
    Expression<String>? airportIcao,
    Expression<double>? length,
    Expression<double>? width,
    Expression<String>? surface,
    Expression<String>? ident,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (airportIcao != null) 'airport_icao': airportIcao,
      if (length != null) 'length': length,
      if (width != null) 'width': width,
      if (surface != null) 'surface': surface,
      if (ident != null) 'ident': ident,
    });
  }

  RunwaysCompanion copyWith({
    Value<int>? id,
    Value<String>? airportIcao,
    Value<double>? length,
    Value<double>? width,
    Value<String?>? surface,
    Value<String>? ident,
  }) {
    return RunwaysCompanion(
      id: id ?? this.id,
      airportIcao: airportIcao ?? this.airportIcao,
      length: length ?? this.length,
      width: width ?? this.width,
      surface: surface ?? this.surface,
      ident: ident ?? this.ident,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (airportIcao.present) {
      map['airport_icao'] = Variable<String>(airportIcao.value);
    }
    if (length.present) {
      map['length'] = Variable<double>(length.value);
    }
    if (width.present) {
      map['width'] = Variable<double>(width.value);
    }
    if (surface.present) {
      map['surface'] = Variable<String>(surface.value);
    }
    if (ident.present) {
      map['ident'] = Variable<String>(ident.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RunwaysCompanion(')
          ..write('id: $id, ')
          ..write('airportIcao: $airportIcao, ')
          ..write('length: $length, ')
          ..write('width: $width, ')
          ..write('surface: $surface, ')
          ..write('ident: $ident')
          ..write(')'))
        .toString();
  }
}

class $FrequenciesTable extends Frequencies
    with TableInfo<$FrequenciesTable, FrequencyData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FrequenciesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _airportIcaoMeta = const VerificationMeta(
    'airportIcao',
  );
  @override
  late final GeneratedColumn<String> airportIcao = GeneratedColumn<String>(
    'airport_icao',
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
  static const VerificationMeta _frequencyMeta = const VerificationMeta(
    'frequency',
  );
  @override
  late final GeneratedColumn<double> frequency = GeneratedColumn<double>(
    'frequency',
    aliasedName,
    false,
    type: DriftSqlType.double,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    airportIcao,
    type,
    frequency,
    description,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'frequencies';
  @override
  VerificationContext validateIntegrity(
    Insertable<FrequencyData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('airport_icao')) {
      context.handle(
        _airportIcaoMeta,
        airportIcao.isAcceptableOrUnknown(
          data['airport_icao']!,
          _airportIcaoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_airportIcaoMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(
        _frequencyMeta,
        frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta),
      );
    } else if (isInserting) {
      context.missing(_frequencyMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FrequencyData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FrequencyData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      airportIcao: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}airport_icao'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      frequency: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}frequency'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $FrequenciesTable createAlias(String alias) {
    return $FrequenciesTable(attachedDatabase, alias);
  }
}

class FrequencyData extends DataClass implements Insertable<FrequencyData> {
  final int id;
  final String airportIcao;
  final String type;
  final double frequency;
  final String? description;
  const FrequencyData({
    required this.id,
    required this.airportIcao,
    required this.type,
    required this.frequency,
    this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['airport_icao'] = Variable<String>(airportIcao);
    map['type'] = Variable<String>(type);
    map['frequency'] = Variable<double>(frequency);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  FrequenciesCompanion toCompanion(bool nullToAbsent) {
    return FrequenciesCompanion(
      id: Value(id),
      airportIcao: Value(airportIcao),
      type: Value(type),
      frequency: Value(frequency),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory FrequencyData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FrequencyData(
      id: serializer.fromJson<int>(json['id']),
      airportIcao: serializer.fromJson<String>(json['airportIcao']),
      type: serializer.fromJson<String>(json['type']),
      frequency: serializer.fromJson<double>(json['frequency']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'airportIcao': serializer.toJson<String>(airportIcao),
      'type': serializer.toJson<String>(type),
      'frequency': serializer.toJson<double>(frequency),
      'description': serializer.toJson<String?>(description),
    };
  }

  FrequencyData copyWith({
    int? id,
    String? airportIcao,
    String? type,
    double? frequency,
    Value<String?> description = const Value.absent(),
  }) => FrequencyData(
    id: id ?? this.id,
    airportIcao: airportIcao ?? this.airportIcao,
    type: type ?? this.type,
    frequency: frequency ?? this.frequency,
    description: description.present ? description.value : this.description,
  );
  FrequencyData copyWithCompanion(FrequenciesCompanion data) {
    return FrequencyData(
      id: data.id.present ? data.id.value : this.id,
      airportIcao: data.airportIcao.present
          ? data.airportIcao.value
          : this.airportIcao,
      type: data.type.present ? data.type.value : this.type,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FrequencyData(')
          ..write('id: $id, ')
          ..write('airportIcao: $airportIcao, ')
          ..write('type: $type, ')
          ..write('frequency: $frequency, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, airportIcao, type, frequency, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FrequencyData &&
          other.id == this.id &&
          other.airportIcao == this.airportIcao &&
          other.type == this.type &&
          other.frequency == this.frequency &&
          other.description == this.description);
}

class FrequenciesCompanion extends UpdateCompanion<FrequencyData> {
  final Value<int> id;
  final Value<String> airportIcao;
  final Value<String> type;
  final Value<double> frequency;
  final Value<String?> description;
  const FrequenciesCompanion({
    this.id = const Value.absent(),
    this.airportIcao = const Value.absent(),
    this.type = const Value.absent(),
    this.frequency = const Value.absent(),
    this.description = const Value.absent(),
  });
  FrequenciesCompanion.insert({
    this.id = const Value.absent(),
    required String airportIcao,
    required String type,
    required double frequency,
    this.description = const Value.absent(),
  }) : airportIcao = Value(airportIcao),
       type = Value(type),
       frequency = Value(frequency);
  static Insertable<FrequencyData> custom({
    Expression<int>? id,
    Expression<String>? airportIcao,
    Expression<String>? type,
    Expression<double>? frequency,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (airportIcao != null) 'airport_icao': airportIcao,
      if (type != null) 'type': type,
      if (frequency != null) 'frequency': frequency,
      if (description != null) 'description': description,
    });
  }

  FrequenciesCompanion copyWith({
    Value<int>? id,
    Value<String>? airportIcao,
    Value<String>? type,
    Value<double>? frequency,
    Value<String?>? description,
  }) {
    return FrequenciesCompanion(
      id: id ?? this.id,
      airportIcao: airportIcao ?? this.airportIcao,
      type: type ?? this.type,
      frequency: frequency ?? this.frequency,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (airportIcao.present) {
      map['airport_icao'] = Variable<String>(airportIcao.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<double>(frequency.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FrequenciesCompanion(')
          ..write('id: $id, ')
          ..write('airportIcao: $airportIcao, ')
          ..write('type: $type, ')
          ..write('frequency: $frequency, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AirportsTable airports = $AirportsTable(this);
  late final $RunwaysTable runways = $RunwaysTable(this);
  late final $FrequenciesTable frequencies = $FrequenciesTable(this);
  late final AirportDao airportDao = AirportDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    airports,
    runways,
    frequencies,
  ];
}

typedef $$AirportsTableCreateCompanionBuilder =
    AirportsCompanion Function({
      required String icao,
      Value<String?> iata,
      required String name,
      required double latitude,
      required double longitude,
      required double elevation,
      required String type,
      Value<String?> municipality,
      required String countryCode,
      Value<int> rowid,
    });
typedef $$AirportsTableUpdateCompanionBuilder =
    AirportsCompanion Function({
      Value<String> icao,
      Value<String?> iata,
      Value<String> name,
      Value<double> latitude,
      Value<double> longitude,
      Value<double> elevation,
      Value<String> type,
      Value<String?> municipality,
      Value<String> countryCode,
      Value<int> rowid,
    });

class $$AirportsTableFilterComposer
    extends Composer<_$AppDatabase, $AirportsTable> {
  $$AirportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get icao => $composableBuilder(
    column: $table.icao,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iata => $composableBuilder(
    column: $table.iata,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
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

  ColumnFilters<double> get elevation => $composableBuilder(
    column: $table.elevation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get municipality => $composableBuilder(
    column: $table.municipality,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AirportsTableOrderingComposer
    extends Composer<_$AppDatabase, $AirportsTable> {
  $$AirportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get icao => $composableBuilder(
    column: $table.icao,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iata => $composableBuilder(
    column: $table.iata,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
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

  ColumnOrderings<double> get elevation => $composableBuilder(
    column: $table.elevation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get municipality => $composableBuilder(
    column: $table.municipality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AirportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AirportsTable> {
  $$AirportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get icao =>
      $composableBuilder(column: $table.icao, builder: (column) => column);

  GeneratedColumn<String> get iata =>
      $composableBuilder(column: $table.iata, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get elevation =>
      $composableBuilder(column: $table.elevation, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get municipality => $composableBuilder(
    column: $table.municipality,
    builder: (column) => column,
  );

  GeneratedColumn<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => column,
  );
}

class $$AirportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AirportsTable,
          AirportData,
          $$AirportsTableFilterComposer,
          $$AirportsTableOrderingComposer,
          $$AirportsTableAnnotationComposer,
          $$AirportsTableCreateCompanionBuilder,
          $$AirportsTableUpdateCompanionBuilder,
          (
            AirportData,
            BaseReferences<_$AppDatabase, $AirportsTable, AirportData>,
          ),
          AirportData,
          PrefetchHooks Function()
        > {
  $$AirportsTableTableManager(_$AppDatabase db, $AirportsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AirportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AirportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AirportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> icao = const Value.absent(),
                Value<String?> iata = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<double> elevation = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> municipality = const Value.absent(),
                Value<String> countryCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AirportsCompanion(
                icao: icao,
                iata: iata,
                name: name,
                latitude: latitude,
                longitude: longitude,
                elevation: elevation,
                type: type,
                municipality: municipality,
                countryCode: countryCode,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String icao,
                Value<String?> iata = const Value.absent(),
                required String name,
                required double latitude,
                required double longitude,
                required double elevation,
                required String type,
                Value<String?> municipality = const Value.absent(),
                required String countryCode,
                Value<int> rowid = const Value.absent(),
              }) => AirportsCompanion.insert(
                icao: icao,
                iata: iata,
                name: name,
                latitude: latitude,
                longitude: longitude,
                elevation: elevation,
                type: type,
                municipality: municipality,
                countryCode: countryCode,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AirportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AirportsTable,
      AirportData,
      $$AirportsTableFilterComposer,
      $$AirportsTableOrderingComposer,
      $$AirportsTableAnnotationComposer,
      $$AirportsTableCreateCompanionBuilder,
      $$AirportsTableUpdateCompanionBuilder,
      (AirportData, BaseReferences<_$AppDatabase, $AirportsTable, AirportData>),
      AirportData,
      PrefetchHooks Function()
    >;
typedef $$RunwaysTableCreateCompanionBuilder =
    RunwaysCompanion Function({
      Value<int> id,
      required String airportIcao,
      required double length,
      required double width,
      Value<String?> surface,
      required String ident,
    });
typedef $$RunwaysTableUpdateCompanionBuilder =
    RunwaysCompanion Function({
      Value<int> id,
      Value<String> airportIcao,
      Value<double> length,
      Value<double> width,
      Value<String?> surface,
      Value<String> ident,
    });

class $$RunwaysTableFilterComposer
    extends Composer<_$AppDatabase, $RunwaysTable> {
  $$RunwaysTableFilterComposer({
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

  ColumnFilters<String> get airportIcao => $composableBuilder(
    column: $table.airportIcao,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get length => $composableBuilder(
    column: $table.length,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get surface => $composableBuilder(
    column: $table.surface,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ident => $composableBuilder(
    column: $table.ident,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RunwaysTableOrderingComposer
    extends Composer<_$AppDatabase, $RunwaysTable> {
  $$RunwaysTableOrderingComposer({
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

  ColumnOrderings<String> get airportIcao => $composableBuilder(
    column: $table.airportIcao,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get length => $composableBuilder(
    column: $table.length,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get surface => $composableBuilder(
    column: $table.surface,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ident => $composableBuilder(
    column: $table.ident,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RunwaysTableAnnotationComposer
    extends Composer<_$AppDatabase, $RunwaysTable> {
  $$RunwaysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get airportIcao => $composableBuilder(
    column: $table.airportIcao,
    builder: (column) => column,
  );

  GeneratedColumn<double> get length =>
      $composableBuilder(column: $table.length, builder: (column) => column);

  GeneratedColumn<double> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<String> get surface =>
      $composableBuilder(column: $table.surface, builder: (column) => column);

  GeneratedColumn<String> get ident =>
      $composableBuilder(column: $table.ident, builder: (column) => column);
}

class $$RunwaysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RunwaysTable,
          RunwayData,
          $$RunwaysTableFilterComposer,
          $$RunwaysTableOrderingComposer,
          $$RunwaysTableAnnotationComposer,
          $$RunwaysTableCreateCompanionBuilder,
          $$RunwaysTableUpdateCompanionBuilder,
          (
            RunwayData,
            BaseReferences<_$AppDatabase, $RunwaysTable, RunwayData>,
          ),
          RunwayData,
          PrefetchHooks Function()
        > {
  $$RunwaysTableTableManager(_$AppDatabase db, $RunwaysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RunwaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RunwaysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RunwaysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> airportIcao = const Value.absent(),
                Value<double> length = const Value.absent(),
                Value<double> width = const Value.absent(),
                Value<String?> surface = const Value.absent(),
                Value<String> ident = const Value.absent(),
              }) => RunwaysCompanion(
                id: id,
                airportIcao: airportIcao,
                length: length,
                width: width,
                surface: surface,
                ident: ident,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String airportIcao,
                required double length,
                required double width,
                Value<String?> surface = const Value.absent(),
                required String ident,
              }) => RunwaysCompanion.insert(
                id: id,
                airportIcao: airportIcao,
                length: length,
                width: width,
                surface: surface,
                ident: ident,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RunwaysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RunwaysTable,
      RunwayData,
      $$RunwaysTableFilterComposer,
      $$RunwaysTableOrderingComposer,
      $$RunwaysTableAnnotationComposer,
      $$RunwaysTableCreateCompanionBuilder,
      $$RunwaysTableUpdateCompanionBuilder,
      (RunwayData, BaseReferences<_$AppDatabase, $RunwaysTable, RunwayData>),
      RunwayData,
      PrefetchHooks Function()
    >;
typedef $$FrequenciesTableCreateCompanionBuilder =
    FrequenciesCompanion Function({
      Value<int> id,
      required String airportIcao,
      required String type,
      required double frequency,
      Value<String?> description,
    });
typedef $$FrequenciesTableUpdateCompanionBuilder =
    FrequenciesCompanion Function({
      Value<int> id,
      Value<String> airportIcao,
      Value<String> type,
      Value<double> frequency,
      Value<String?> description,
    });

class $$FrequenciesTableFilterComposer
    extends Composer<_$AppDatabase, $FrequenciesTable> {
  $$FrequenciesTableFilterComposer({
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

  ColumnFilters<String> get airportIcao => $composableBuilder(
    column: $table.airportIcao,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FrequenciesTableOrderingComposer
    extends Composer<_$AppDatabase, $FrequenciesTable> {
  $$FrequenciesTableOrderingComposer({
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

  ColumnOrderings<String> get airportIcao => $composableBuilder(
    column: $table.airportIcao,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FrequenciesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FrequenciesTable> {
  $$FrequenciesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get airportIcao => $composableBuilder(
    column: $table.airportIcao,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );
}

class $$FrequenciesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FrequenciesTable,
          FrequencyData,
          $$FrequenciesTableFilterComposer,
          $$FrequenciesTableOrderingComposer,
          $$FrequenciesTableAnnotationComposer,
          $$FrequenciesTableCreateCompanionBuilder,
          $$FrequenciesTableUpdateCompanionBuilder,
          (
            FrequencyData,
            BaseReferences<_$AppDatabase, $FrequenciesTable, FrequencyData>,
          ),
          FrequencyData,
          PrefetchHooks Function()
        > {
  $$FrequenciesTableTableManager(_$AppDatabase db, $FrequenciesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FrequenciesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FrequenciesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FrequenciesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> airportIcao = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<double> frequency = const Value.absent(),
                Value<String?> description = const Value.absent(),
              }) => FrequenciesCompanion(
                id: id,
                airportIcao: airportIcao,
                type: type,
                frequency: frequency,
                description: description,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String airportIcao,
                required String type,
                required double frequency,
                Value<String?> description = const Value.absent(),
              }) => FrequenciesCompanion.insert(
                id: id,
                airportIcao: airportIcao,
                type: type,
                frequency: frequency,
                description: description,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FrequenciesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FrequenciesTable,
      FrequencyData,
      $$FrequenciesTableFilterComposer,
      $$FrequenciesTableOrderingComposer,
      $$FrequenciesTableAnnotationComposer,
      $$FrequenciesTableCreateCompanionBuilder,
      $$FrequenciesTableUpdateCompanionBuilder,
      (
        FrequencyData,
        BaseReferences<_$AppDatabase, $FrequenciesTable, FrequencyData>,
      ),
      FrequencyData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AirportsTableTableManager get airports =>
      $$AirportsTableTableManager(_db, _db.airports);
  $$RunwaysTableTableManager get runways =>
      $$RunwaysTableTableManager(_db, _db.runways);
  $$FrequenciesTableTableManager get frequencies =>
      $$FrequenciesTableTableManager(_db, _db.frequencies);
}
