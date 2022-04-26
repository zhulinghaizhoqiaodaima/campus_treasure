/**
 *物品详情
 */
 
import { mPost } from "../utils/request/xhr";
 
const getGoodsDatail = (path,params) => mPost(path, params);
 
export { getGoodsDatail };