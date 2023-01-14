// Delete 通过主键id删除数据，返回受影响行数
func (d *default{{.upperStartCamelObject}}Model) Delete(ctx context.Context, {{.lowerStartCamelPrimaryKey}} {{.dataType}}) (int64, error) {
	logx.WithContext(ctx).Infof("delete data:%+v", {{.lowerStartCamelPrimaryKey}})

    if {{.lowerStartCamelPrimaryKey}} <= 0 {
        logx.WithContext(ctx).Errorf("delete error:%+v", "param invalid")
        return 0, InputParamInvalid
    }

	result := d.DB.Debug().WithContext(ctx).Where("{{.originalPrimaryKey}} = ?", {{.lowerStartCamelPrimaryKey}}).Delete(&{{.upperStartCamelObject}}{})
	if result.Error != nil {
		logx.WithContext(ctx).Errorf("delete error:%+v", result.Error)
		return 0, WriteDataFailed
	}

	return result.RowsAffected, nil
}

// TxDelete 用于事务删除数据，由上层(如rpc层)调用Transaction去实现，返回受影响行数
func (d *default{{.upperStartCamelObject}}Model) TxDelete(ctx context.Context, tx *gorm.DB, {{.lowerStartCamelPrimaryKey}} {{.dataType}}) (int64, error) {
	logx.WithContext(ctx).Infof("txDelete data:%+v", {{.lowerStartCamelPrimaryKey}})

    if {{.lowerStartCamelPrimaryKey}} <= 0 {
        logx.WithContext(ctx).Errorf("txDelete error:%+v", "param invalid")
        return 0, InputParamInvalid
    }

	result := tx.Debug().WithContext(ctx).Where("{{.originalPrimaryKey}} = ?", {{.lowerStartCamelPrimaryKey}}).Delete(&{{.upperStartCamelObject}}{})
	if result.Error != nil {
		logx.WithContext(ctx).Errorf("txDelete error:%+v", result.Error)
		return 0, WriteDataFailed
	}

	return result.RowsAffected, nil
}

// Deletes 通过主键id批量删除数据，返回受影响行数
func (d *default{{.upperStartCamelObject}}Model) Deletes(ctx context.Context, {{.lowerStartCamelPrimaryKey}}s []{{.dataType}}) (int64, error) {
	logx.WithContext(ctx).Infof("deletes data:%+v", {{.lowerStartCamelPrimaryKey}}s)

    if len({{.lowerStartCamelPrimaryKey}}s) == 0 {
        logx.WithContext(ctx).Errorf("deletes error:%+v", "param invalid")
        return 0, InputParamInvalid
    }

	result := d.DB.Debug().WithContext(ctx).Where("{{.originalPrimaryKey}} in ?", {{.lowerStartCamelPrimaryKey}}s).Delete(&{{.upperStartCamelObject}}{})
	if result.Error != nil {
		logx.WithContext(ctx).Errorf("deletes error:%+v", result.Error)
		return 0, WriteDataFailed
	}

	return result.RowsAffected, nil
}

// TxDeletes 用于事务批量删除数据，由上层(如rpc层)调用Transaction去实现，返回受影响行数
func (d *default{{.upperStartCamelObject}}Model) TxDeletes(ctx context.Context, tx *gorm.DB, {{.lowerStartCamelPrimaryKey}}s []{{.dataType}}) (int64, error) {
	logx.WithContext(ctx).Infof("txDeletes data:%+v", {{.lowerStartCamelPrimaryKey}}s)

    if len({{.lowerStartCamelPrimaryKey}}s) == 0 {
        logx.WithContext(ctx).Errorf("txDeletes error:%+v", "param invalid")
        return 0, InputParamInvalid
    }

	result := tx.Debug().WithContext(ctx).Where("{{.originalPrimaryKey}} in ?", {{.lowerStartCamelPrimaryKey}}s).Delete(&{{.upperStartCamelObject}}{})
	if result.Error != nil {
		logx.WithContext(ctx).Errorf("txDeletes error:%+v", result.Error)
		return 0, WriteDataFailed
	}

	return result.RowsAffected, nil
}