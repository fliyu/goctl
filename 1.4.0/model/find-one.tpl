// FindOne 通过主键id查找数据
func (d *default{{.upperStartCamelObject}}Model) FindOne(ctx context.Context, {{.lowerStartCamelPrimaryKey}} {{.dataType}}) (*{{.upperStartCamelObject}}, error) {
	logx.WithContext(ctx).Infof("findOne data:%+v", {{.lowerStartCamelPrimaryKey}})

    if {{.lowerStartCamelPrimaryKey}} <= 0 {
		logx.WithContext(ctx).Errorf("findOne error:%+v", "param invalid")
		return nil, InputParamInvalid
	}

	var result {{.upperStartCamelObject}}
	err := d.DB.Debug().WithContext(ctx).Where("{{.originalPrimaryKey}} = ?", {{.lowerStartCamelPrimaryKey}}).First(&result).Error
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrNotFound
		}
		logx.WithContext(ctx).Errorf("findOne error:%+v", err)
		return nil, ReadDataFailed
	}

	return &result, nil
}

// Finds 按条件查询，不分页
// queries: 查询条件集合;
// orders: 排序字符串
func (d *default{{.upperStartCamelObject}}Model) Finds(ctx context.Context, queries []Query, orders []Order) ([]*{{.upperStartCamelObject}}, error) {
	logx.WithContext(ctx).Infof("finds queries: %+v, orders: %+v", queries, orders)

	var result []*{{.upperStartCamelObject}}
    db := d.DB.Debug().WithContext(ctx)
    for _, query := range queries {
        db = db.Where(fmt.Sprintf("`%s` %s ?", query.Field, query.Condition), query.Value)
    }

	for _, order := range orders {
        if order.ASC {
            db = db.Order(fmt.Sprintf("%s asc", order.Field))
        } else {
            db = db.Order(fmt.Sprintf("%s desc", order.Field))
        }
    }

	err := db.Find(&result).Error
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrNotFound
		}
		logx.WithContext(ctx).Errorf("finds error:%+v", err)
		return nil, ReadDataFailed
	}

	return result, nil
}

// FindsByPage 分页查询
// queries: 查询条件集合;
// page: 分页条件
// orders: 排序字符串
func (d *default{{.upperStartCamelObject}}Model) FindsByPage(ctx context.Context, queries []Query, page *Page, orders []Order) ([]*{{.upperStartCamelObject}}, int64, error) {
	logx.WithContext(ctx).Infof("findsByPage queries: %+v, page: %+v, orders: %+v", queries, page, orders)

	var result []*{{.upperStartCamelObject}}
	var count int64
    db := d.DB.Debug().WithContext(ctx)
    for _, query := range queries {
        db = db.Where(fmt.Sprintf("`%s` %s ?", query.Field, query.Condition), query.Value)
    }

	err := db.Model(&{{.upperStartCamelObject}}{}).Count(&count).Error
    if err != nil {
        logx.WithContext(ctx).Errorf("findsByPage error:%+v", err)
        return nil, 0, ReadDataFailed
    }

    for _, order := range orders {
        if order.ASC {
            db = db.Order(fmt.Sprintf("%s asc", order.Field))
        } else {
            db = db.Order(fmt.Sprintf("%s desc", order.Field))
        }
    }

    if page != nil {
        if page.PageIndex < 0 {
            page.PageIndex = 0
        }
        if page.PageSize <= 0 {
            page.PageSize = 20
        }
        if page.PageSize >= 100 {
            page.PageSize = 100
        }

        db = db.Offset(page.PageIndex * page.PageSize).Limit(page.PageSize)
    }

    err = db.Find(result).Error
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, 0, ErrNotFound
		}
		logx.WithContext(ctx).Errorf("findsByPage error:%+v", err)
		return nil, 0, ReadDataFailed
	}

	return result, count, nil
}


// FindCount 按条件查询记录条数
// queries: 查询条件集合;
func (d *default{{.upperStartCamelObject}}Model) FindCount(ctx context.Context, queries []Query) (int64, error) {
	logx.WithContext(ctx).Infof("findCount queries: %+v", queries)

	db := d.DB.Debug().WithContext(ctx)
    for _, query := range queries {
        db = db.Where(fmt.Sprintf("`%s` %s ?", query.Field, query.Condition), query.Value)
    }

	var count int64
    err := db.Model(&{{.upperStartCamelObject}}{}).Count(&count).Error
    if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return 0, ErrNotFound
		}
		logx.WithContext(ctx).Errorf("findCount error:%+v", err)
        return 0, ReadDataFailed
    }

	return count, nil
}