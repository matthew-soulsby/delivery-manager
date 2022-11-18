// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetDeliveryCollection on Isar {
  IsarCollection<Delivery> get deliverys => this.collection();
}

const DeliverySchema = CollectionSchema(
  name: r'Delivery',
  id: 1954919988841945312,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'itemsToDeliver': PropertySchema(
      id: 1,
      name: r'itemsToDeliver',
      type: IsarType.objectList,
      target: r'Item',
    ),
    r'payment': PropertySchema(
      id: 2,
      name: r'payment',
      type: IsarType.object,
      target: r'Payment',
    ),
    r'recurrance': PropertySchema(
      id: 3,
      name: r'recurrance',
      type: IsarType.int,
      enumMap: _DeliveryrecurranceEnumValueMap,
    )
  },
  estimateSize: _deliveryEstimateSize,
  serialize: _deliverySerialize,
  deserialize: _deliveryDeserialize,
  deserializeProp: _deliveryDeserializeProp,
  idName: r'id',
  indexes: {
    r'date': IndexSchema(
      id: -7552997827385218417,
      name: r'date',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'date',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'customer': LinkSchema(
      id: 4296550612515695417,
      name: r'customer',
      target: r'Customer',
      single: true,
    )
  },
  embeddedSchemas: {r'Item': ItemSchema, r'Payment': PaymentSchema},
  getId: _deliveryGetId,
  getLinks: _deliveryGetLinks,
  attach: _deliveryAttach,
  version: '3.0.5',
);

int _deliveryEstimateSize(
  Delivery object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.itemsToDeliver;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[Item]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += ItemSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.payment;
    if (value != null) {
      bytesCount += 3 +
          PaymentSchema.estimateSize(value, allOffsets[Payment]!, allOffsets);
    }
  }
  return bytesCount;
}

void _deliverySerialize(
  Delivery object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeObjectList<Item>(
    offsets[1],
    allOffsets,
    ItemSchema.serialize,
    object.itemsToDeliver,
  );
  writer.writeObject<Payment>(
    offsets[2],
    allOffsets,
    PaymentSchema.serialize,
    object.payment,
  );
  writer.writeInt(offsets[3], object.recurrance?.index);
}

Delivery _deliveryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Delivery();
  object.date = reader.readDateTimeOrNull(offsets[0]);
  object.id = id;
  object.itemsToDeliver = reader.readObjectList<Item>(
    offsets[1],
    ItemSchema.deserialize,
    allOffsets,
    Item(),
  );
  object.payment = reader.readObjectOrNull<Payment>(
    offsets[2],
    PaymentSchema.deserialize,
    allOffsets,
  );
  object.recurrance =
      _DeliveryrecurranceValueEnumMap[reader.readIntOrNull(offsets[3])];
  return object;
}

P _deliveryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readObjectList<Item>(
        offset,
        ItemSchema.deserialize,
        allOffsets,
        Item(),
      )) as P;
    case 2:
      return (reader.readObjectOrNull<Payment>(
        offset,
        PaymentSchema.deserialize,
        allOffsets,
      )) as P;
    case 3:
      return (_DeliveryrecurranceValueEnumMap[reader.readIntOrNull(offset)])
          as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _DeliveryrecurranceEnumValueMap = {
  'everyWeek': 0,
  'everySecondWeek': 1,
  'everyThirdWeek': 2,
  'everyFourthWeek': 3,
};
const _DeliveryrecurranceValueEnumMap = {
  0: Recurrance.everyWeek,
  1: Recurrance.everySecondWeek,
  2: Recurrance.everyThirdWeek,
  3: Recurrance.everyFourthWeek,
};

Id _deliveryGetId(Delivery object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _deliveryGetLinks(Delivery object) {
  return [object.customer];
}

void _deliveryAttach(IsarCollection<dynamic> col, Id id, Delivery object) {
  object.id = id;
  object.customer.attach(col, col.isar.collection<Customer>(), r'customer', id);
}

extension DeliveryQueryWhereSort on QueryBuilder<Delivery, Delivery, QWhere> {
  QueryBuilder<Delivery, Delivery, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension DeliveryQueryWhere on QueryBuilder<Delivery, Delivery, QWhereClause> {
  QueryBuilder<Delivery, Delivery, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterWhereClause> dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date',
        value: [null],
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterWhereClause> dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterWhereClause> dateEqualTo(
      DateTime? date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date',
        value: [date],
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterWhereClause> dateNotEqualTo(
      DateTime? date) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterWhereClause> dateGreaterThan(
    DateTime? date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [date],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterWhereClause> dateLessThan(
    DateTime? date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [],
        upper: [date],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterWhereClause> dateBetween(
    DateTime? lowerDate,
    DateTime? upperDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [lowerDate],
        includeLower: includeLower,
        upper: [upperDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DeliveryQueryFilter
    on QueryBuilder<Delivery, Delivery, QFilterCondition> {
  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> dateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> dateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> dateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> dateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition>
      itemsToDeliverIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'itemsToDeliver',
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition>
      itemsToDeliverIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'itemsToDeliver',
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition>
      itemsToDeliverLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'itemsToDeliver',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition>
      itemsToDeliverIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'itemsToDeliver',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition>
      itemsToDeliverIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'itemsToDeliver',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition>
      itemsToDeliverLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'itemsToDeliver',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition>
      itemsToDeliverLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'itemsToDeliver',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition>
      itemsToDeliverLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'itemsToDeliver',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> paymentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'payment',
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> paymentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'payment',
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> recurranceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recurrance',
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition>
      recurranceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recurrance',
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> recurranceEqualTo(
      Recurrance? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recurrance',
        value: value,
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> recurranceGreaterThan(
    Recurrance? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recurrance',
        value: value,
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> recurranceLessThan(
    Recurrance? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recurrance',
        value: value,
      ));
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> recurranceBetween(
    Recurrance? lower,
    Recurrance? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recurrance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DeliveryQueryObject
    on QueryBuilder<Delivery, Delivery, QFilterCondition> {
  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> itemsToDeliverElement(
      FilterQuery<Item> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'itemsToDeliver');
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> payment(
      FilterQuery<Payment> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'payment');
    });
  }
}

extension DeliveryQueryLinks
    on QueryBuilder<Delivery, Delivery, QFilterCondition> {
  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> customer(
      FilterQuery<Customer> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'customer');
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterFilterCondition> customerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'customer', 0, true, 0, true);
    });
  }
}

extension DeliveryQuerySortBy on QueryBuilder<Delivery, Delivery, QSortBy> {
  QueryBuilder<Delivery, Delivery, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterSortBy> sortByRecurrance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurrance', Sort.asc);
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterSortBy> sortByRecurranceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurrance', Sort.desc);
    });
  }
}

extension DeliveryQuerySortThenBy
    on QueryBuilder<Delivery, Delivery, QSortThenBy> {
  QueryBuilder<Delivery, Delivery, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterSortBy> thenByRecurrance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurrance', Sort.asc);
    });
  }

  QueryBuilder<Delivery, Delivery, QAfterSortBy> thenByRecurranceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurrance', Sort.desc);
    });
  }
}

extension DeliveryQueryWhereDistinct
    on QueryBuilder<Delivery, Delivery, QDistinct> {
  QueryBuilder<Delivery, Delivery, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<Delivery, Delivery, QDistinct> distinctByRecurrance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recurrance');
    });
  }
}

extension DeliveryQueryProperty
    on QueryBuilder<Delivery, Delivery, QQueryProperty> {
  QueryBuilder<Delivery, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Delivery, DateTime?, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<Delivery, List<Item>?, QQueryOperations>
      itemsToDeliverProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'itemsToDeliver');
    });
  }

  QueryBuilder<Delivery, Payment?, QQueryOperations> paymentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'payment');
    });
  }

  QueryBuilder<Delivery, Recurrance?, QQueryOperations> recurranceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recurrance');
    });
  }
}
