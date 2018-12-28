export interface Page<TModel> {
  isSuccess?: boolean;
  items?: TModel[];
  pageNo: number;
  pageSize: number;
  total: number;
}
