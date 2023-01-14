
// Update 通过主键id更新指定字段，零值不可更新，返回受影响行数
func (d *default{{.upperStartCamelObject}}Model) Update(ctx context.Context, id int64, data *{{.upperStartCamelObject}}) (int64, error) {
	logx.WithContext(ctx).Infof("update data:%+v", data)

	if id <= 0 {
		logx.WithContext(ctx).Errorf("update error:%+v", "param invalid")
		return 0, InputParamInvalid
	}

	result := d.DB.Debug().WithContext(ctx).Where("{{.originalPrimaryKey}} = ?", id).Updates(data)
	if result.Error != nil {
		logx.WithContext(ctx).Errorf("update error:%+v", result.Error)
		return 0, WriteDataFailed
	}

	return result.RowsAffected, nil
}


// TxUpdate 用于事务更新数据，由上层(如rpc层)调用Transaction去实现，零值不可更新，返回受影响行数
func (d *default{{.upperStartCamelObject}}Model) TxUpdate(ctx context.Context, tx *gorm.DB, id int64, data *{{.upperStartCamelObject}}) (int64, error) {
	logx.WithContext(ctx).Infof("txUpdate data:%+v", data)

	if id <= 0 {
		logx.WithContext(ctx).Errorf("txUpdate error:%+v", "param invalid")
		return 0, InputParamInvalid
	}

	result := tx.Debug().WithContext(ctx).Where("{{.originalPrimaryKey}} = ?", id).Updates(data)
	if result.Error != nil {
		logx.WithContext(ctx).Errorf("update error:%+v", result.Error)
		return 0, WriteDataFailed
	}

	return result.RowsAffected, nil
}

// UpdateOneMapById 通过主键id更新字段，map参数为数据库需要更新的字段，返回受影响行数
func (d *default{{.upperStartCamelObject}}Model) UpdateOneMapById(ctx context.Context, id int64, data map[string]interface{}) (int64, error) {
	logx.WithContext(ctx).Infof("updateOneMapById data:%+v", data)

	if id <= 0 {
		logx.WithContext(ctx).Errorf("updateOneMapById error:%+v", "param invalid")
		return 0, InputParamInvalid
	}

	result := d.DB.Debug().WithContext(ctx).Model(&{{.upperStartCamelObject}}{}).Where("{{.originalPrimaryKey}} = ?", id).Updates(data)
	if result.Error != nil {
		logx.WithContext(ctx).Errorf("updateOneMapById error:%+v", result.Error)
		return 0, WriteDataFailed
	}

	return result.RowsAffected, nil
}

// TxUpdateOneMapById 用于事务更新字段，由上层(如rpc层)调用Transaction去实现，返回受影响的行数
// tx：上层传递时请加上context
func (d *default{{.upperStartCamelObject}}Model) TxUpdateOneMapById(ctx context.Context, tx *gorm.DB, id int64, data map[string]interface{}) (int64, error) {
	logx.WithContext(ctx).Infof("txUpdateOneMapById data:%+v", data)

	if id <= 0 {
		logx.WithContext(ctx).Errorf("txUpdateOneMapById error:%+v", "param invalid")
		return 0, InputParamInvalid
	}

	result := tx.Debug().WithContext(ctx).Model(&{{.upperStartCamelObject}}{}).Where("{{.originalPrimaryKey}} = ?", id).Updates(data)
	if result.Error != nil {
		logx.WithContext(ctx).Errorf("txUpdateOneMapById error:%+v", result.Error)
		return 0, WriteDataFailed
	}

	return result.RowsAffected, nil
}