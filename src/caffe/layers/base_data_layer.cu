#include <vector>

#include "caffe/layers/base_data_layer.hpp"

namespace caffe {

template<typename Ftype, typename Btype>
void BasePrefetchingDataLayer<Ftype, Btype>::Forward_gpu(const vector<Blob*>& bottom,
    const vector<Blob*>& top) {
  // Note: this function runs in one thread per object and one object per one Solver thread
//  shared_ptr<Batch> batch =
//      prefetches_full_[next_batch_queue_]->pop("Data layer prefetch queue empty");
//
////  if (batch->data_packing() == this->transform_param_.forward_packing()
////      && top[0]->shape() == batch->data_->shape()) {
////    top[0]->Swap(*batch->data_);
////  } else {
////    top[0]->safe_reshape_mode(true);
//
//  tmp_.Reshape(batch->data_->shape());
//  tmp_.set_cpu_data(batch->data_->template mutable_cpu_data<Btype>());
//
//  top[0]->CopyDataFrom(tmp_, true, batch->data_packing(),
//        this->transform_param_.forward_packing());
//
//  if (this->output_labels_) {
////    top[1]->Swap(*batch->label_);
//    top[1]->CopyDataFrom(*batch->label_);
//
////    LOG(INFO) <<top[1]->to_string();
//
//  }
//  batch->set_id((size_t) -1L);
//  prefetches_free_[next_batch_queue_]->push(batch);
//  next_batch_queue();

  shared_ptr<Batch> batch = this->batch_transformer_->processed_pop();
  top[0]->Swap(*batch->data_);
  if (this->output_labels_) {
    top[1]->Swap(*batch->label_);
  }
  this->batch_transformer_->processed_push(batch);
}

INSTANTIATE_LAYER_GPU_FORWARD_ONLY_FB(BasePrefetchingDataLayer);

}  // namespace caffe
