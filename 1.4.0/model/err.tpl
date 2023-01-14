package {{.pkg}}

import (
	"errors"
	"gorm.io/gorm"
)

var (
    ErrNotFound = gorm.ErrRecordNotFound
    InputParamInvalid = errors.New("param invalid")
    WriteDataFailed   = errors.New("write data failed")
    ReadDataFailed    = errors.New("read data failed")
)

type Query struct {
	Field     string
	Condition ConditionType
	Value     interface{}
}

type ConditionType string

const (
	ConditionEqual    = "="
	ConditionNotEqual = "<>"
	ConditionGt       = ">"
	ConditionGte      = ">="
	ConditionLt       = "<"
	ConditionLte      = "<="
	ConditionIn       = "IN"
	ConditionNotIn    = "NOT IN"
	ConditionLike     = "LIKE"
)

type Page struct {
	PageIndex int // 页面索引，从0开始
	PageSize  int // 页面条数，默认20，最多100
}

type Order struct {
	Field string
	ASC   bool
}
