// Insert 返回的是受影响行数，如需获取自增id，请通过data参数获取
func (d *default{{.upperStartCamelObject}}Model) Insert(ctx context.Context, data *{{.upperStartCamelObject}}) (int64, error) {
	logx.WithContext(ctx).Infof("insert data:%+v", data)

    if data == nil {
		logx.WithContext(ctx).Errorf("insert error:%+v", "param invalid")
		return 0, InputParamInvalid
	}

	result := d.DB.Debug().WithContext(ctx).Create(data)
	if result.Error != nil {
		logx.WithContext(ctx).Errorf("insert error:%+v", result.Error)
		return 0, WriteDataFailed
	}

	return result.RowsAffected, nil
}

// TxInsert // 用于事务新增数据，由上层(如rpc层)调用Transaction去实现，返回受影响的行数
// tx：上层传递时请加上context
func (d *default{{.upperStartCamelObject}}Model) TxInsert(ctx context.Context, tx *gorm.DB, data *{{.upperStartCamelObject}}) (int64, error) {
	logx.WithContext(ctx).Infof("txInsert data:%+v", data)

    if data == nil {
        logx.WithContext(ctx).Errorf("txInsert error:%+v", "param invalid")
        return 0, InputParamInvalid
    }

	result := tx.Debug().WithContext(ctx).Create(data)
	if result.Error != nil {
		logx.WithContext(ctx).Errorf("txInsert error:%+v", result.Error)
		return 0, WriteDataFailed
	}

	return result.RowsAffected, nil
}