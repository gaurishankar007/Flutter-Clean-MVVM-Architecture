// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $KeyValueLocalTable extends KeyValueLocal
    with TableInfo<$KeyValueLocalTable, KeyValueLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KeyValueLocalTable(this.attachedDatabase, [this._alias]);
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
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'key_value';
  @override
  VerificationContext validateIntegrity(
    Insertable<KeyValueLocalData> instance, {
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  KeyValueLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KeyValueLocalData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $KeyValueLocalTable createAlias(String alias) {
    return $KeyValueLocalTable(attachedDatabase, alias);
  }
}

class KeyValueLocalData extends DataClass
    implements Insertable<KeyValueLocalData> {
  final String key;
  final String value;
  const KeyValueLocalData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  KeyValueLocalCompanion toCompanion(bool nullToAbsent) {
    return KeyValueLocalCompanion(key: Value(key), value: Value(value));
  }

  factory KeyValueLocalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KeyValueLocalData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  KeyValueLocalData copyWith({String? key, String? value}) =>
      KeyValueLocalData(key: key ?? this.key, value: value ?? this.value);
  KeyValueLocalData copyWithCompanion(KeyValueLocalCompanion data) {
    return KeyValueLocalData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KeyValueLocalData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KeyValueLocalData &&
          other.key == this.key &&
          other.value == this.value);
}

class KeyValueLocalCompanion extends UpdateCompanion<KeyValueLocalData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const KeyValueLocalCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KeyValueLocalCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<KeyValueLocalData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KeyValueLocalCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return KeyValueLocalCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KeyValueLocalCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ErrorLogLocalTable extends ErrorLogLocal
    with TableInfo<$ErrorLogLocalTable, ErrorLogLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ErrorLogLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _errorMeta = const VerificationMeta('error');
  @override
  late final GeneratedColumn<String> error = GeneratedColumn<String>(
    'error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _shownMeta = const VerificationMeta('shown');
  @override
  late final GeneratedColumn<bool> shown = GeneratedColumn<bool>(
    'shown',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("shown" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    action,
    source,
    message,
    error,
    shown,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'error_log';
  @override
  VerificationContext validateIntegrity(
    Insertable<ErrorLogLocalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('error')) {
      context.handle(
        _errorMeta,
        error.isAcceptableOrUnknown(data['error']!, _errorMeta),
      );
    }
    if (data.containsKey('shown')) {
      context.handle(
        _shownMeta,
        shown.isAcceptableOrUnknown(data['shown']!, _shownMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ErrorLogLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ErrorLogLocalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      ),
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      error: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error'],
      ),
      shown: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}shown'],
      )!,
    );
  }

  @override
  $ErrorLogLocalTable createAlias(String alias) {
    return $ErrorLogLocalTable(attachedDatabase, alias);
  }
}

class ErrorLogLocalData extends DataClass
    implements Insertable<ErrorLogLocalData> {
  final String id;
  final DateTime createdAt;

  /// Flow and operation labels, outermost first: `todos.save > todo.local.upsert`.
  final String? action;

  /// The notifier that showed it.
  final String? source;
  final String message;
  final String? error;
  final bool shown;
  const ErrorLogLocalData({
    required this.id,
    required this.createdAt,
    this.action,
    this.source,
    required this.message,
    this.error,
    required this.shown,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || action != null) {
      map['action'] = Variable<String>(action);
    }
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    map['message'] = Variable<String>(message);
    if (!nullToAbsent || error != null) {
      map['error'] = Variable<String>(error);
    }
    map['shown'] = Variable<bool>(shown);
    return map;
  }

  ErrorLogLocalCompanion toCompanion(bool nullToAbsent) {
    return ErrorLogLocalCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      action: action == null && nullToAbsent
          ? const Value.absent()
          : Value(action),
      source: source == null && nullToAbsent
          ? const Value.absent()
          : Value(source),
      message: Value(message),
      error: error == null && nullToAbsent
          ? const Value.absent()
          : Value(error),
      shown: Value(shown),
    );
  }

  factory ErrorLogLocalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ErrorLogLocalData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      action: serializer.fromJson<String?>(json['action']),
      source: serializer.fromJson<String?>(json['source']),
      message: serializer.fromJson<String>(json['message']),
      error: serializer.fromJson<String?>(json['error']),
      shown: serializer.fromJson<bool>(json['shown']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'action': serializer.toJson<String?>(action),
      'source': serializer.toJson<String?>(source),
      'message': serializer.toJson<String>(message),
      'error': serializer.toJson<String?>(error),
      'shown': serializer.toJson<bool>(shown),
    };
  }

  ErrorLogLocalData copyWith({
    String? id,
    DateTime? createdAt,
    Value<String?> action = const Value.absent(),
    Value<String?> source = const Value.absent(),
    String? message,
    Value<String?> error = const Value.absent(),
    bool? shown,
  }) => ErrorLogLocalData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    action: action.present ? action.value : this.action,
    source: source.present ? source.value : this.source,
    message: message ?? this.message,
    error: error.present ? error.value : this.error,
    shown: shown ?? this.shown,
  );
  ErrorLogLocalData copyWithCompanion(ErrorLogLocalCompanion data) {
    return ErrorLogLocalData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      action: data.action.present ? data.action.value : this.action,
      source: data.source.present ? data.source.value : this.source,
      message: data.message.present ? data.message.value : this.message,
      error: data.error.present ? data.error.value : this.error,
      shown: data.shown.present ? data.shown.value : this.shown,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ErrorLogLocalData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('action: $action, ')
          ..write('source: $source, ')
          ..write('message: $message, ')
          ..write('error: $error, ')
          ..write('shown: $shown')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, action, source, message, error, shown);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ErrorLogLocalData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.action == this.action &&
          other.source == this.source &&
          other.message == this.message &&
          other.error == this.error &&
          other.shown == this.shown);
}

class ErrorLogLocalCompanion extends UpdateCompanion<ErrorLogLocalData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<String?> action;
  final Value<String?> source;
  final Value<String> message;
  final Value<String?> error;
  final Value<bool> shown;
  final Value<int> rowid;
  const ErrorLogLocalCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.action = const Value.absent(),
    this.source = const Value.absent(),
    this.message = const Value.absent(),
    this.error = const Value.absent(),
    this.shown = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ErrorLogLocalCompanion.insert({
    required String id,
    required DateTime createdAt,
    this.action = const Value.absent(),
    this.source = const Value.absent(),
    required String message,
    this.error = const Value.absent(),
    this.shown = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       message = Value(message);
  static Insertable<ErrorLogLocalData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? action,
    Expression<String>? source,
    Expression<String>? message,
    Expression<String>? error,
    Expression<bool>? shown,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (action != null) 'action': action,
      if (source != null) 'source': source,
      if (message != null) 'message': message,
      if (error != null) 'error': error,
      if (shown != null) 'shown': shown,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ErrorLogLocalCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<String?>? action,
    Value<String?>? source,
    Value<String>? message,
    Value<String?>? error,
    Value<bool>? shown,
    Value<int>? rowid,
  }) {
    return ErrorLogLocalCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      action: action ?? this.action,
      source: source ?? this.source,
      message: message ?? this.message,
      error: error ?? this.error,
      shown: shown ?? this.shown,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (error.present) {
      map['error'] = Variable<String>(error.value);
    }
    if (shown.present) {
      map['shown'] = Variable<bool>(shown.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ErrorLogLocalCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('action: $action, ')
          ..write('source: $source, ')
          ..write('message: $message, ')
          ..write('error: $error, ')
          ..write('shown: $shown, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TodoLocalTable extends TodoLocal
    with TableInfo<$TodoLocalTable, TodoLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<DateTime> dueAt = GeneratedColumn<DateTime>(
    'due_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subtasksMeta = const VerificationMeta(
    'subtasks',
  );
  @override
  late final GeneratedColumn<String> subtasks = GeneratedColumn<String>(
    'subtasks',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
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
    remoteId,
    title,
    notes,
    isCompleted,
    priority,
    category,
    dueAt,
    completedAt,
    subtasks,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todos';
  @override
  VerificationContext validateIntegrity(
    Insertable<TodoLocalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('subtasks')) {
      context.handle(
        _subtasksMeta,
        subtasks.isAcceptableOrUnknown(data['subtasks']!, _subtasksMeta),
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
  TodoLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoLocalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remote_id'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      dueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_at'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      subtasks: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subtasks'],
      )!,
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
  $TodoLocalTable createAlias(String alias) {
    return $TodoLocalTable(attachedDatabase, alias);
  }
}

class TodoLocalData extends DataClass implements Insertable<TodoLocalData> {
  final String id;
  final int? remoteId;
  final String title;
  final String notes;
  final bool isCompleted;

  /// `TodoPriority.name` / `TodoCategory.name`.
  final String priority;
  final String category;
  final DateTime? dueAt;
  final DateTime? completedAt;

  /// JSON list of `{id, title, isDone}`.
  final String subtasks;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TodoLocalData({
    required this.id,
    this.remoteId,
    required this.title,
    required this.notes,
    required this.isCompleted,
    required this.priority,
    required this.category,
    this.dueAt,
    this.completedAt,
    required this.subtasks,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<int>(remoteId);
    }
    map['title'] = Variable<String>(title);
    map['notes'] = Variable<String>(notes);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['priority'] = Variable<String>(priority);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || dueAt != null) {
      map['due_at'] = Variable<DateTime>(dueAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['subtasks'] = Variable<String>(subtasks);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TodoLocalCompanion toCompanion(bool nullToAbsent) {
    return TodoLocalCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      title: Value(title),
      notes: Value(notes),
      isCompleted: Value(isCompleted),
      priority: Value(priority),
      category: Value(category),
      dueAt: dueAt == null && nullToAbsent
          ? const Value.absent()
          : Value(dueAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      subtasks: Value(subtasks),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TodoLocalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoLocalData(
      id: serializer.fromJson<String>(json['id']),
      remoteId: serializer.fromJson<int?>(json['remoteId']),
      title: serializer.fromJson<String>(json['title']),
      notes: serializer.fromJson<String>(json['notes']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      priority: serializer.fromJson<String>(json['priority']),
      category: serializer.fromJson<String>(json['category']),
      dueAt: serializer.fromJson<DateTime?>(json['dueAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      subtasks: serializer.fromJson<String>(json['subtasks']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'remoteId': serializer.toJson<int?>(remoteId),
      'title': serializer.toJson<String>(title),
      'notes': serializer.toJson<String>(notes),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'priority': serializer.toJson<String>(priority),
      'category': serializer.toJson<String>(category),
      'dueAt': serializer.toJson<DateTime?>(dueAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'subtasks': serializer.toJson<String>(subtasks),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TodoLocalData copyWith({
    String? id,
    Value<int?> remoteId = const Value.absent(),
    String? title,
    String? notes,
    bool? isCompleted,
    String? priority,
    String? category,
    Value<DateTime?> dueAt = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    String? subtasks,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => TodoLocalData(
    id: id ?? this.id,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    title: title ?? this.title,
    notes: notes ?? this.notes,
    isCompleted: isCompleted ?? this.isCompleted,
    priority: priority ?? this.priority,
    category: category ?? this.category,
    dueAt: dueAt.present ? dueAt.value : this.dueAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    subtasks: subtasks ?? this.subtasks,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TodoLocalData copyWithCompanion(TodoLocalCompanion data) {
    return TodoLocalData(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      title: data.title.present ? data.title.value : this.title,
      notes: data.notes.present ? data.notes.value : this.notes,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      priority: data.priority.present ? data.priority.value : this.priority,
      category: data.category.present ? data.category.value : this.category,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      subtasks: data.subtasks.present ? data.subtasks.value : this.subtasks,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TodoLocalData(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('priority: $priority, ')
          ..write('category: $category, ')
          ..write('dueAt: $dueAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('subtasks: $subtasks, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    remoteId,
    title,
    notes,
    isCompleted,
    priority,
    category,
    dueAt,
    completedAt,
    subtasks,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoLocalData &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.title == this.title &&
          other.notes == this.notes &&
          other.isCompleted == this.isCompleted &&
          other.priority == this.priority &&
          other.category == this.category &&
          other.dueAt == this.dueAt &&
          other.completedAt == this.completedAt &&
          other.subtasks == this.subtasks &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TodoLocalCompanion extends UpdateCompanion<TodoLocalData> {
  final Value<String> id;
  final Value<int?> remoteId;
  final Value<String> title;
  final Value<String> notes;
  final Value<bool> isCompleted;
  final Value<String> priority;
  final Value<String> category;
  final Value<DateTime?> dueAt;
  final Value<DateTime?> completedAt;
  final Value<String> subtasks;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TodoLocalCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.priority = const Value.absent(),
    this.category = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.subtasks = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TodoLocalCompanion.insert({
    required String id,
    this.remoteId = const Value.absent(),
    required String title,
    this.notes = const Value.absent(),
    this.isCompleted = const Value.absent(),
    required String priority,
    required String category,
    this.dueAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.subtasks = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       priority = Value(priority),
       category = Value(category),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<TodoLocalData> custom({
    Expression<String>? id,
    Expression<int>? remoteId,
    Expression<String>? title,
    Expression<String>? notes,
    Expression<bool>? isCompleted,
    Expression<String>? priority,
    Expression<String>? category,
    Expression<DateTime>? dueAt,
    Expression<DateTime>? completedAt,
    Expression<String>? subtasks,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (title != null) 'title': title,
      if (notes != null) 'notes': notes,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (priority != null) 'priority': priority,
      if (category != null) 'category': category,
      if (dueAt != null) 'due_at': dueAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (subtasks != null) 'subtasks': subtasks,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TodoLocalCompanion copyWith({
    Value<String>? id,
    Value<int?>? remoteId,
    Value<String>? title,
    Value<String>? notes,
    Value<bool>? isCompleted,
    Value<String>? priority,
    Value<String>? category,
    Value<DateTime?>? dueAt,
    Value<DateTime?>? completedAt,
    Value<String>? subtasks,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return TodoLocalCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      dueAt: dueAt ?? this.dueAt,
      completedAt: completedAt ?? this.completedAt,
      subtasks: subtasks ?? this.subtasks,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<DateTime>(dueAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (subtasks.present) {
      map['subtasks'] = Variable<String>(subtasks.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
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
    return (StringBuffer('TodoLocalCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('priority: $priority, ')
          ..write('category: $category, ')
          ..write('dueAt: $dueAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('subtasks: $subtasks, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationLocalTable extends NotificationLocal
    with TableInfo<$NotificationLocalTable, NotificationLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _todoIdMeta = const VerificationMeta('todoId');
  @override
  late final GeneratedColumn<String> todoId = GeneratedColumn<String>(
    'todo_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    title,
    body,
    todoId,
    isRead,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notifications';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationLocalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('todo_id')) {
      context.handle(
        _todoIdMeta,
        todoId.isAcceptableOrUnknown(data['todo_id']!, _todoIdMeta),
      );
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
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
  NotificationLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationLocalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      todoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}todo_id'],
      ),
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $NotificationLocalTable createAlias(String alias) {
    return $NotificationLocalTable(attachedDatabase, alias);
  }
}

class NotificationLocalData extends DataClass
    implements Insertable<NotificationLocalData> {
  final String id;

  /// `NotificationType.name`.
  final String type;
  final String title;
  final String body;
  final String? todoId;
  final bool isRead;
  final DateTime createdAt;
  const NotificationLocalData({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    this.todoId,
    required this.isRead,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    if (!nullToAbsent || todoId != null) {
      map['todo_id'] = Variable<String>(todoId);
    }
    map['is_read'] = Variable<bool>(isRead);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  NotificationLocalCompanion toCompanion(bool nullToAbsent) {
    return NotificationLocalCompanion(
      id: Value(id),
      type: Value(type),
      title: Value(title),
      body: Value(body),
      todoId: todoId == null && nullToAbsent
          ? const Value.absent()
          : Value(todoId),
      isRead: Value(isRead),
      createdAt: Value(createdAt),
    );
  }

  factory NotificationLocalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationLocalData(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      todoId: serializer.fromJson<String?>(json['todoId']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'todoId': serializer.toJson<String?>(todoId),
      'isRead': serializer.toJson<bool>(isRead),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  NotificationLocalData copyWith({
    String? id,
    String? type,
    String? title,
    String? body,
    Value<String?> todoId = const Value.absent(),
    bool? isRead,
    DateTime? createdAt,
  }) => NotificationLocalData(
    id: id ?? this.id,
    type: type ?? this.type,
    title: title ?? this.title,
    body: body ?? this.body,
    todoId: todoId.present ? todoId.value : this.todoId,
    isRead: isRead ?? this.isRead,
    createdAt: createdAt ?? this.createdAt,
  );
  NotificationLocalData copyWithCompanion(NotificationLocalCompanion data) {
    return NotificationLocalData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      todoId: data.todoId.present ? data.todoId.value : this.todoId,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationLocalData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('todoId: $todoId, ')
          ..write('isRead: $isRead, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, title, body, todoId, isRead, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationLocalData &&
          other.id == this.id &&
          other.type == this.type &&
          other.title == this.title &&
          other.body == this.body &&
          other.todoId == this.todoId &&
          other.isRead == this.isRead &&
          other.createdAt == this.createdAt);
}

class NotificationLocalCompanion
    extends UpdateCompanion<NotificationLocalData> {
  final Value<String> id;
  final Value<String> type;
  final Value<String> title;
  final Value<String> body;
  final Value<String?> todoId;
  final Value<bool> isRead;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const NotificationLocalCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.todoId = const Value.absent(),
    this.isRead = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationLocalCompanion.insert({
    required String id,
    required String type,
    required String title,
    required String body,
    this.todoId = const Value.absent(),
    this.isRead = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       title = Value(title),
       body = Value(body),
       createdAt = Value(createdAt);
  static Insertable<NotificationLocalData> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String>? todoId,
    Expression<bool>? isRead,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (todoId != null) 'todo_id': todoId,
      if (isRead != null) 'is_read': isRead,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationLocalCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<String>? title,
    Value<String>? body,
    Value<String?>? todoId,
    Value<bool>? isRead,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return NotificationLocalCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      body: body ?? this.body,
      todoId: todoId ?? this.todoId,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (todoId.present) {
      map['todo_id'] = Variable<String>(todoId.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationLocalCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('todoId: $todoId, ')
          ..write('isRead: $isRead, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $KeyValueLocalTable keyValueLocal = $KeyValueLocalTable(this);
  late final $ErrorLogLocalTable errorLogLocal = $ErrorLogLocalTable(this);
  late final $TodoLocalTable todoLocal = $TodoLocalTable(this);
  late final $NotificationLocalTable notificationLocal =
      $NotificationLocalTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    keyValueLocal,
    errorLogLocal,
    todoLocal,
    notificationLocal,
  ];
}

typedef $$KeyValueLocalTableCreateCompanionBuilder =
    KeyValueLocalCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$KeyValueLocalTableUpdateCompanionBuilder =
    KeyValueLocalCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$KeyValueLocalTableFilterComposer
    extends Composer<_$AppDatabase, $KeyValueLocalTable> {
  $$KeyValueLocalTableFilterComposer({
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
}

class $$KeyValueLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $KeyValueLocalTable> {
  $$KeyValueLocalTableOrderingComposer({
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
}

class $$KeyValueLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $KeyValueLocalTable> {
  $$KeyValueLocalTableAnnotationComposer({
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
}

class $$KeyValueLocalTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KeyValueLocalTable,
          KeyValueLocalData,
          $$KeyValueLocalTableFilterComposer,
          $$KeyValueLocalTableOrderingComposer,
          $$KeyValueLocalTableAnnotationComposer,
          $$KeyValueLocalTableCreateCompanionBuilder,
          $$KeyValueLocalTableUpdateCompanionBuilder,
          (
            KeyValueLocalData,
            BaseReferences<
              _$AppDatabase,
              $KeyValueLocalTable,
              KeyValueLocalData
            >,
          ),
          KeyValueLocalData,
          PrefetchHooks Function()
        > {
  $$KeyValueLocalTableTableManager(_$AppDatabase db, $KeyValueLocalTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KeyValueLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KeyValueLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KeyValueLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => KeyValueLocalCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => KeyValueLocalCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$KeyValueLocalTable, KeyValueLocalData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $KeyValueLocalTable,
                    KeyValueLocalData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KeyValueLocalTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KeyValueLocalTable,
      KeyValueLocalData,
      $$KeyValueLocalTableFilterComposer,
      $$KeyValueLocalTableOrderingComposer,
      $$KeyValueLocalTableAnnotationComposer,
      $$KeyValueLocalTableCreateCompanionBuilder,
      $$KeyValueLocalTableUpdateCompanionBuilder,
      (
        KeyValueLocalData,
        BaseReferences<_$AppDatabase, $KeyValueLocalTable, KeyValueLocalData>,
      ),
      KeyValueLocalData,
      PrefetchHooks Function()
    >;
typedef $$ErrorLogLocalTableCreateCompanionBuilder =
    ErrorLogLocalCompanion Function({
      required String id,
      required DateTime createdAt,
      Value<String?> action,
      Value<String?> source,
      required String message,
      Value<String?> error,
      Value<bool> shown,
      Value<int> rowid,
    });
typedef $$ErrorLogLocalTableUpdateCompanionBuilder =
    ErrorLogLocalCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<String?> action,
      Value<String?> source,
      Value<String> message,
      Value<String?> error,
      Value<bool> shown,
      Value<int> rowid,
    });

class $$ErrorLogLocalTableFilterComposer
    extends Composer<_$AppDatabase, $ErrorLogLocalTable> {
  $$ErrorLogLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get error => $composableBuilder(
    column: $table.error,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get shown => $composableBuilder(
    column: $table.shown,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ErrorLogLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $ErrorLogLocalTable> {
  $$ErrorLogLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get error => $composableBuilder(
    column: $table.error,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get shown => $composableBuilder(
    column: $table.shown,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ErrorLogLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $ErrorLogLocalTable> {
  $$ErrorLogLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get error =>
      $composableBuilder(column: $table.error, builder: (column) => column);

  GeneratedColumn<bool> get shown =>
      $composableBuilder(column: $table.shown, builder: (column) => column);
}

class $$ErrorLogLocalTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ErrorLogLocalTable,
          ErrorLogLocalData,
          $$ErrorLogLocalTableFilterComposer,
          $$ErrorLogLocalTableOrderingComposer,
          $$ErrorLogLocalTableAnnotationComposer,
          $$ErrorLogLocalTableCreateCompanionBuilder,
          $$ErrorLogLocalTableUpdateCompanionBuilder,
          (
            ErrorLogLocalData,
            BaseReferences<
              _$AppDatabase,
              $ErrorLogLocalTable,
              ErrorLogLocalData
            >,
          ),
          ErrorLogLocalData,
          PrefetchHooks Function()
        > {
  $$ErrorLogLocalTableTableManager(_$AppDatabase db, $ErrorLogLocalTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ErrorLogLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ErrorLogLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ErrorLogLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> action = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<String?> error = const Value.absent(),
                Value<bool> shown = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ErrorLogLocalCompanion(
                id: id,
                createdAt: createdAt,
                action: action,
                source: source,
                message: message,
                error: error,
                shown: shown,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                Value<String?> action = const Value.absent(),
                Value<String?> source = const Value.absent(),
                required String message,
                Value<String?> error = const Value.absent(),
                Value<bool> shown = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ErrorLogLocalCompanion.insert(
                id: id,
                createdAt: createdAt,
                action: action,
                source: source,
                message: message,
                error: error,
                shown: shown,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ErrorLogLocalTable, ErrorLogLocalData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ErrorLogLocalTable,
                    ErrorLogLocalData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ErrorLogLocalTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ErrorLogLocalTable,
      ErrorLogLocalData,
      $$ErrorLogLocalTableFilterComposer,
      $$ErrorLogLocalTableOrderingComposer,
      $$ErrorLogLocalTableAnnotationComposer,
      $$ErrorLogLocalTableCreateCompanionBuilder,
      $$ErrorLogLocalTableUpdateCompanionBuilder,
      (
        ErrorLogLocalData,
        BaseReferences<_$AppDatabase, $ErrorLogLocalTable, ErrorLogLocalData>,
      ),
      ErrorLogLocalData,
      PrefetchHooks Function()
    >;
typedef $$TodoLocalTableCreateCompanionBuilder = TodoLocalCompanion Function({
  required String id,
  Value<int?> remoteId,
  required String title,
  Value<String> notes,
  Value<bool> isCompleted,
  required String priority,
  required String category,
  Value<DateTime?> dueAt,
  Value<DateTime?> completedAt,
  Value<String> subtasks,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$TodoLocalTableUpdateCompanionBuilder = TodoLocalCompanion Function({
  Value<String> id,
  Value<int?> remoteId,
  Value<String> title,
  Value<String> notes,
  Value<bool> isCompleted,
  Value<String> priority,
  Value<String> category,
  Value<DateTime?> dueAt,
  Value<DateTime?> completedAt,
  Value<String> subtasks,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$TodoLocalTableFilterComposer
    extends Composer<_$AppDatabase, $TodoLocalTable> {
  $$TodoLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subtasks => $composableBuilder(
    column: $table.subtasks,
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

class $$TodoLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $TodoLocalTable> {
  $$TodoLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subtasks => $composableBuilder(
    column: $table.subtasks,
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

class $$TodoLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $TodoLocalTable> {
  $$TodoLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get subtasks =>
      $composableBuilder(column: $table.subtasks, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TodoLocalTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TodoLocalTable,
          TodoLocalData,
          $$TodoLocalTableFilterComposer,
          $$TodoLocalTableOrderingComposer,
          $$TodoLocalTableAnnotationComposer,
          $$TodoLocalTableCreateCompanionBuilder,
          $$TodoLocalTableUpdateCompanionBuilder,
          (
            TodoLocalData,
            BaseReferences<_$AppDatabase, $TodoLocalTable, TodoLocalData>,
          ),
          TodoLocalData,
          PrefetchHooks Function()
        > {
  $$TodoLocalTableTableManager(_$AppDatabase db, $TodoLocalTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TodoLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TodoLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TodoLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<DateTime?> dueAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String> subtasks = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TodoLocalCompanion(
                id: id,
                remoteId: remoteId,
                title: title,
                notes: notes,
                isCompleted: isCompleted,
                priority: priority,
                category: category,
                dueAt: dueAt,
                completedAt: completedAt,
                subtasks: subtasks,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<int?> remoteId = const Value.absent(),
                required String title,
                Value<String> notes = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                required String priority,
                required String category,
                Value<DateTime?> dueAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String> subtasks = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => TodoLocalCompanion.insert(
                id: id,
                remoteId: remoteId,
                title: title,
                notes: notes,
                isCompleted: isCompleted,
                priority: priority,
                category: category,
                dueAt: dueAt,
                completedAt: completedAt,
                subtasks: subtasks,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TodoLocalTable, TodoLocalData>(table),
                  BaseReferences<_$AppDatabase, $TodoLocalTable, TodoLocalData>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TodoLocalTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TodoLocalTable,
      TodoLocalData,
      $$TodoLocalTableFilterComposer,
      $$TodoLocalTableOrderingComposer,
      $$TodoLocalTableAnnotationComposer,
      $$TodoLocalTableCreateCompanionBuilder,
      $$TodoLocalTableUpdateCompanionBuilder,
      (
        TodoLocalData,
        BaseReferences<_$AppDatabase, $TodoLocalTable, TodoLocalData>,
      ),
      TodoLocalData,
      PrefetchHooks Function()
    >;
typedef $$NotificationLocalTableCreateCompanionBuilder =
    NotificationLocalCompanion Function({
      required String id,
      required String type,
      required String title,
      required String body,
      Value<String?> todoId,
      Value<bool> isRead,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$NotificationLocalTableUpdateCompanionBuilder =
    NotificationLocalCompanion Function({
      Value<String> id,
      Value<String> type,
      Value<String> title,
      Value<String> body,
      Value<String?> todoId,
      Value<bool> isRead,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$NotificationLocalTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationLocalTable> {
  $$NotificationLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get todoId => $composableBuilder(
    column: $table.todoId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationLocalTable> {
  $$NotificationLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get todoId => $composableBuilder(
    column: $table.todoId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationLocalTable> {
  $$NotificationLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get todoId =>
      $composableBuilder(column: $table.todoId, builder: (column) => column);

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$NotificationLocalTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationLocalTable,
          NotificationLocalData,
          $$NotificationLocalTableFilterComposer,
          $$NotificationLocalTableOrderingComposer,
          $$NotificationLocalTableAnnotationComposer,
          $$NotificationLocalTableCreateCompanionBuilder,
          $$NotificationLocalTableUpdateCompanionBuilder,
          (
            NotificationLocalData,
            BaseReferences<
              _$AppDatabase,
              $NotificationLocalTable,
              NotificationLocalData
            >,
          ),
          NotificationLocalData,
          PrefetchHooks Function()
        > {
  $$NotificationLocalTableTableManager(
    _$AppDatabase db,
    $NotificationLocalTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationLocalTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<String?> todoId = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationLocalCompanion(
                id: id,
                type: type,
                title: title,
                body: body,
                todoId: todoId,
                isRead: isRead,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String type,
                required String title,
                required String body,
                Value<String?> todoId = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => NotificationLocalCompanion.insert(
                id: id,
                type: type,
                title: title,
                body: body,
                todoId: todoId,
                isRead: isRead,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NotificationLocalTable, NotificationLocalData>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $NotificationLocalTable,
                    NotificationLocalData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationLocalTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationLocalTable,
      NotificationLocalData,
      $$NotificationLocalTableFilterComposer,
      $$NotificationLocalTableOrderingComposer,
      $$NotificationLocalTableAnnotationComposer,
      $$NotificationLocalTableCreateCompanionBuilder,
      $$NotificationLocalTableUpdateCompanionBuilder,
      (
        NotificationLocalData,
        BaseReferences<
          _$AppDatabase,
          $NotificationLocalTable,
          NotificationLocalData
        >,
      ),
      NotificationLocalData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$KeyValueLocalTableTableManager get keyValueLocal =>
      $$KeyValueLocalTableTableManager(_db, _db.keyValueLocal);
  $$ErrorLogLocalTableTableManager get errorLogLocal =>
      $$ErrorLogLocalTableTableManager(_db, _db.errorLogLocal);
  $$TodoLocalTableTableManager get todoLocal =>
      $$TodoLocalTableTableManager(_db, _db.todoLocal);
  $$NotificationLocalTableTableManager get notificationLocal =>
      $$NotificationLocalTableTableManager(_db, _db.notificationLocal);
}
