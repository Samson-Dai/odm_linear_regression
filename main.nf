// All arguments:
// 1. odm file path: odm_fp
// 2. metadata file path: meta_fp
// 3. two target cells (1 indexed column): x, y
// 4. the number of split of the dataset: k
// 5. results dir: result_dir
params.result_file_name = "result.rds"
//create a channel
group_ids = Channel.from(1..params.k)

/******************
* Fit linear model
*******************/
process fit_linear_model {
  output:
  file 'raw_result.rds' into raw_results_ch

  input:
  path odm_fp from params.odm_fp
  path meta_fp from params.meta_fp
  val x from params.x
  val y from params.y
  val k from params.k
  val i from group_ids

  // args: 1. odm file path
  // 2. meta data file path
  // 3. cell index x
  // 4. cell index y
  // 5. number of split k
  // 6. group id i
  """
  fit_linear.R $odm_fp $meta_fp $x $y $k $i
  """
}

/***************************
* Average fitted coefficient
****************************/
process average_coefficient {
  publishDir params.result_dir, mode: "copy"

  output:
  file "$params.result_file_name" into collected_results_ch

  input:
  file 'raw_result' from raw_results_ch.collect()

  """
  average_coef.R $params.result_file_name raw_result*
  """
}
