
// FindOneBy{{.upperField}} 通过指定字段查找数据
func (d *default{{.upperStartCamelObject}}Model) FindOneBy{{.upperField}}(ctx context.Context, {{.in}}) (*{{.upperStartCamelObject}}, error) {
	logx.WithContext(ctx).Infof("findOneBy{{.upperField}} data:%+v", {{.lowerStartCamelField}})

	var result {{.upperStartCamelObject}}
	err := d.DB.Debug().WithContext(ctx).Where("{{.originalField}}", {{.lowerStartCamelField}}).First(&result).Error
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrNotFound
		}
	    logx.WithContext(ctx).Errorf("findOneBy{{.upperField}} error:%+v", err)
		return nil, err
	}

	return &result, nil
}
