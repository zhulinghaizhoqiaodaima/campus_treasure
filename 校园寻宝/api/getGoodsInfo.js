/**
 *获取物品信息
 */
 
import { mGet, mPost } from "../utils/request/xhr";
 
const getGoodsInfo = (params) => mGet("/goods/page", params);
 
export { getGoodsInfo };