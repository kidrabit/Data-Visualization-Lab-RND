
C
global_step/initial_valueConst*
dtype0*
value	B : 
W
global_step
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
global_step/AssignAssignglobal_stepglobal_step/initial_value*
T0*
_class
loc:@global_step*
use_locking(*
validate_shape(
R
global_step/readIdentityglobal_step*
T0*
_class
loc:@global_step
;
steps_to_incrementPlaceholder*
dtype0*
shape: 
9
AddAddglobal_step/readsteps_to_increment*
T0
t
AssignAssignglobal_stepAdd*
T0*
_class
loc:@global_step*
use_locking(*
validate_shape(
L
vector_observationPlaceholder*
dtype0*
shape:���������
w
%normalization_steps/Initializer/zerosConst*&
_class
loc:@normalization_steps*
dtype0*
value	B : 
�
normalization_steps
VariableV2*&
_class
loc:@normalization_steps*
	container *
dtype0*
shape: *
shared_name 
�
normalization_steps/AssignAssignnormalization_steps%normalization_steps/Initializer/zeros*
T0*&
_class
loc:@normalization_steps*
use_locking(*
validate_shape(
j
normalization_steps/readIdentitynormalization_steps*
T0*&
_class
loc:@normalization_steps
p
running_mean/Initializer/zerosConst*
_class
loc:@running_mean*
dtype0*
valueB*    
}
running_mean
VariableV2*
_class
loc:@running_mean*
	container *
dtype0*
shape:*
shared_name 
�
running_mean/AssignAssignrunning_meanrunning_mean/Initializer/zeros*
T0*
_class
loc:@running_mean*
use_locking(*
validate_shape(
U
running_mean/readIdentityrunning_mean*
T0*
_class
loc:@running_mean
w
!running_variance/Initializer/onesConst*#
_class
loc:@running_variance*
dtype0*
valueB*  �?
�
running_variance
VariableV2*#
_class
loc:@running_variance*
	container *
dtype0*
shape:*
shared_name 
�
running_variance/AssignAssignrunning_variance!running_variance/Initializer/ones*
T0*#
_class
loc:@running_variance*
use_locking(*
validate_shape(
a
running_variance/readIdentityrunning_variance*
T0*#
_class
loc:@running_variance
;
ShapeShapevector_observation*
T0*
out_type0
A
strided_slice/stackConst*
dtype0*
valueB: 
C
strided_slice/stack_1Const*
dtype0*
valueB:
C
strided_slice/stack_2Const*
dtype0*
valueB:
�
strided_sliceStridedSliceShapestrided_slice/stackstrided_slice/stack_1strided_slice/stack_2*
Index0*
T0*

begin_mask *
ellipsis_mask *
end_mask *
new_axis_mask *
shrink_axis_mask
>
Add_1Addnormalization_steps/readstrided_slice*
T0
:
SubSubvector_observationrunning_mean/read*
T0
;
CastCastAdd_1*

DstT0*

SrcT0*
Truncate( 
&
truedivRealDivSubCast*
T0
?
Sum/reduction_indicesConst*
dtype0*
value	B : 
P
SumSumtruedivSum/reduction_indices*
T0*

Tidx0*
	keep_dims( 
/
add_2AddV2running_mean/readSum*
T0
0
Sub_1Subvector_observationadd_2*
T0

mulMulSub_1Sub*
T0
A
Sum_1/reduction_indicesConst*
dtype0*
value	B : 
P
Sum_1SummulSum_1/reduction_indices*
T0*

Tidx0*
	keep_dims( 
5
add_3AddV2running_variance/readSum_1*
T0
z
Assign_1Assignrunning_meanadd_2*
T0*
_class
loc:@running_mean*
use_locking(*
validate_shape(
�
Assign_2Assignrunning_varianceadd_3*
T0*#
_class
loc:@running_variance*
use_locking(*
validate_shape(
�
Assign_3Assignnormalization_stepsAdd_1*
T0*&
_class
loc:@normalization_steps*
use_locking(*
validate_shape(
L
moments/mean/reduction_indicesConst*
dtype0*
valueB: 
n
moments/meanMeanvector_observationmoments/mean/reduction_indices*
T0*

Tidx0*
	keep_dims(
;
moments/StopGradientStopGradientmoments/mean*
T0
a
moments/SquaredDifferenceSquaredDifferencevector_observationmoments/StopGradient*
T0
P
"moments/variance/reduction_indicesConst*
dtype0*
valueB: 
}
moments/varianceMeanmoments/SquaredDifference"moments/variance/reduction_indices*
T0*

Tidx0*
	keep_dims(
H
moments/SqueezeSqueezemoments/mean*
T0*
squeeze_dims
 
N
moments/Squeeze_1Squeezemoments/variance*
T0*
squeeze_dims
 
�
Assign_4Assignrunning_meanmoments/Squeeze*
T0*
_class
loc:@running_mean*
use_locking(*
validate_shape(
4
add_4/yConst*
dtype0*
valueB
 *���3
3
add_4AddV2moments/Squeeze_1add_4/y*
T0
=
Cast_1CastAdd_1*

DstT0*

SrcT0*
Truncate( 
$
mul_1Muladd_4Cast_1*
T0
�
Assign_5Assignrunning_variancemul_1*
T0*#
_class
loc:@running_variance*
use_locking(*
validate_shape(
3

group_depsNoOp	^Assign_3	^Assign_4	^Assign_5
5
group_deps_1NoOp	^Assign_1	^Assign_2	^Assign_3
<
sub_2Subvector_observationrunning_mean/read*
T0
P
Cast_2Castnormalization_steps/read*

DstT0*

SrcT0*
Truncate( 
4
add_5/yConst*
dtype0*
valueB
 *  �?
(
add_5AddV2Cast_2add_5/y*
T0
;
	truediv_1RealDivrunning_variance/readadd_5*
T0
 
SqrtSqrt	truediv_1*
T0
*
	truediv_2RealDivsub_2Sqrt*
T0
G
normalized_state/Minimum/yConst*
dtype0*
valueB
 *  �@
S
normalized_state/MinimumMinimum	truediv_2normalized_state/Minimum/y*
T0
?
normalized_state/yConst*
dtype0*
valueB
 *  ��
R
normalized_stateMaximumnormalized_state/Minimumnormalized_state/y*
T0
5

batch_sizePlaceholder*
dtype0*
shape:
:
sequence_lengthPlaceholder*
dtype0*
shape:
;
masksPlaceholder*
dtype0*
shape:���������
A
epsilonPlaceholder*
dtype0*
shape:���������
=
Cast_3Castmasks*

DstT0*

SrcT0*
Truncate( 
M
#is_continuous_control/initial_valueConst*
dtype0*
value	B : 
a
is_continuous_control
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
is_continuous_control/AssignAssignis_continuous_control#is_continuous_control/initial_value*
T0*(
_class
loc:@is_continuous_control*
use_locking(*
validate_shape(
p
is_continuous_control/readIdentityis_continuous_control*
T0*(
_class
loc:@is_continuous_control
M
#trainer_major_version/initial_valueConst*
dtype0*
value	B : 
a
trainer_major_version
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
trainer_major_version/AssignAssigntrainer_major_version#trainer_major_version/initial_value*
T0*(
_class
loc:@trainer_major_version*
use_locking(*
validate_shape(
p
trainer_major_version/readIdentitytrainer_major_version*
T0*(
_class
loc:@trainer_major_version
M
#trainer_minor_version/initial_valueConst*
dtype0*
value	B :
a
trainer_minor_version
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
trainer_minor_version/AssignAssigntrainer_minor_version#trainer_minor_version/initial_value*
T0*(
_class
loc:@trainer_minor_version*
use_locking(*
validate_shape(
p
trainer_minor_version/readIdentitytrainer_minor_version*
T0*(
_class
loc:@trainer_minor_version
M
#trainer_patch_version/initial_valueConst*
dtype0*
value	B : 
a
trainer_patch_version
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
trainer_patch_version/AssignAssigntrainer_patch_version#trainer_patch_version/initial_value*
T0*(
_class
loc:@trainer_patch_version*
use_locking(*
validate_shape(
p
trainer_patch_version/readIdentitytrainer_patch_version*
T0*(
_class
loc:@trainer_patch_version
F
version_number/initial_valueConst*
dtype0*
value	B :
Z
version_number
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
version_number/AssignAssignversion_numberversion_number/initial_value*
T0*!
_class
loc:@version_number*
use_locking(*
validate_shape(
[
version_number/readIdentityversion_number*
T0*!
_class
loc:@version_number
C
memory_size/initial_valueConst*
dtype0*
value	B : 
W
memory_size
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
memory_size/AssignAssignmemory_sizememory_size/initial_value*
T0*
_class
loc:@memory_size*
use_locking(*
validate_shape(
R
memory_size/readIdentitymemory_size*
T0*
_class
loc:@memory_size
K
!action_output_shape/initial_valueConst*
dtype0*
value	B :
_
action_output_shape
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
action_output_shape/AssignAssignaction_output_shape!action_output_shape/initial_value*
T0*&
_class
loc:@action_output_shape*
use_locking(*
validate_shape(
j
action_output_shape/readIdentityaction_output_shape*
T0*&
_class
loc:@action_output_shape
�
Fpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/shapeConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB"   �   
�
Epolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/meanConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB
 *    
�
Gpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/stddevConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB
 *���>
�
Ppolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormalFpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/shape*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
seed�(*
seed2 
�
Dpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/mulMulPpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormalGpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/stddev*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel
�
@policy/main_graph_0/hidden_0/kernel/Initializer/truncated_normalAddDpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/mulEpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/mean*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel
�
#policy/main_graph_0/hidden_0/kernel
VariableV2*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
*policy/main_graph_0/hidden_0/kernel/AssignAssign#policy/main_graph_0/hidden_0/kernel@policy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
(policy/main_graph_0/hidden_0/kernel/readIdentity#policy/main_graph_0/hidden_0/kernel*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel
�
3policy/main_graph_0/hidden_0/bias/Initializer/zerosConst*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
dtype0*
valueB�*    
�
!policy/main_graph_0/hidden_0/bias
VariableV2*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
	container *
dtype0*
shape:�*
shared_name 
�
(policy/main_graph_0/hidden_0/bias/AssignAssign!policy/main_graph_0/hidden_0/bias3policy/main_graph_0/hidden_0/bias/Initializer/zeros*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
&policy/main_graph_0/hidden_0/bias/readIdentity!policy/main_graph_0/hidden_0/bias*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias
�
#policy/main_graph_0/hidden_0/MatMulMatMulnormalized_state(policy/main_graph_0/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
$policy/main_graph_0/hidden_0/BiasAddBiasAdd#policy/main_graph_0/hidden_0/MatMul&policy/main_graph_0/hidden_0/bias/read*
T0*
data_formatNHWC
^
$policy/main_graph_0/hidden_0/SigmoidSigmoid$policy/main_graph_0/hidden_0/BiasAdd*
T0
|
 policy/main_graph_0/hidden_0/MulMul$policy/main_graph_0/hidden_0/BiasAdd$policy/main_graph_0/hidden_0/Sigmoid*
T0
�
Fpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/shapeConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB"�   �   
�
Epolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/meanConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB
 *    
�
Gpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/stddevConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB
 *���=
�
Ppolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormalFpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/shape*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
seed�(*
seed2
�
Dpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/mulMulPpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormalGpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/stddev*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel
�
@policy/main_graph_0/hidden_1/kernel/Initializer/truncated_normalAddDpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/mulEpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/mean*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel
�
#policy/main_graph_0/hidden_1/kernel
VariableV2*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
*policy/main_graph_0/hidden_1/kernel/AssignAssign#policy/main_graph_0/hidden_1/kernel@policy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
(policy/main_graph_0/hidden_1/kernel/readIdentity#policy/main_graph_0/hidden_1/kernel*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel
�
3policy/main_graph_0/hidden_1/bias/Initializer/zerosConst*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
dtype0*
valueB�*    
�
!policy/main_graph_0/hidden_1/bias
VariableV2*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
	container *
dtype0*
shape:�*
shared_name 
�
(policy/main_graph_0/hidden_1/bias/AssignAssign!policy/main_graph_0/hidden_1/bias3policy/main_graph_0/hidden_1/bias/Initializer/zeros*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
&policy/main_graph_0/hidden_1/bias/readIdentity!policy/main_graph_0/hidden_1/bias*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias
�
#policy/main_graph_0/hidden_1/MatMulMatMul policy/main_graph_0/hidden_0/Mul(policy/main_graph_0/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
$policy/main_graph_0/hidden_1/BiasAddBiasAdd#policy/main_graph_0/hidden_1/MatMul&policy/main_graph_0/hidden_1/bias/read*
T0*
data_formatNHWC
^
$policy/main_graph_0/hidden_1/SigmoidSigmoid$policy/main_graph_0/hidden_1/BiasAdd*
T0
|
 policy/main_graph_0/hidden_1/MulMul$policy/main_graph_0/hidden_1/BiasAdd$policy/main_graph_0/hidden_1/Sigmoid*
T0
F
action_masksPlaceholder*
dtype0*
shape:���������
�
6policy/dense/kernel/Initializer/truncated_normal/shapeConst*&
_class
loc:@policy/dense/kernel*
dtype0*
valueB"�      
�
5policy/dense/kernel/Initializer/truncated_normal/meanConst*&
_class
loc:@policy/dense/kernel*
dtype0*
valueB
 *    
�
7policy/dense/kernel/Initializer/truncated_normal/stddevConst*&
_class
loc:@policy/dense/kernel*
dtype0*
valueB
 *�$<
�
@policy/dense/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormal6policy/dense/kernel/Initializer/truncated_normal/shape*
T0*&
_class
loc:@policy/dense/kernel*
dtype0*
seed�(*
seed2
�
4policy/dense/kernel/Initializer/truncated_normal/mulMul@policy/dense/kernel/Initializer/truncated_normal/TruncatedNormal7policy/dense/kernel/Initializer/truncated_normal/stddev*
T0*&
_class
loc:@policy/dense/kernel
�
0policy/dense/kernel/Initializer/truncated_normalAdd4policy/dense/kernel/Initializer/truncated_normal/mul5policy/dense/kernel/Initializer/truncated_normal/mean*
T0*&
_class
loc:@policy/dense/kernel
�
policy/dense/kernel
VariableV2*&
_class
loc:@policy/dense/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
policy/dense/kernel/AssignAssignpolicy/dense/kernel0policy/dense/kernel/Initializer/truncated_normal*
T0*&
_class
loc:@policy/dense/kernel*
use_locking(*
validate_shape(
j
policy/dense/kernel/readIdentitypolicy/dense/kernel*
T0*&
_class
loc:@policy/dense/kernel
�
policy_1/dense/MatMulMatMul policy/main_graph_0/hidden_1/Mulpolicy/dense/kernel/read*
T0*
transpose_a( *
transpose_b( 
Q
policy_1/strided_slice/stackConst*
dtype0*
valueB"        
S
policy_1/strided_slice/stack_1Const*
dtype0*
valueB"       
S
policy_1/strided_slice/stack_2Const*
dtype0*
valueB"      
�
policy_1/strided_sliceStridedSliceaction_maskspolicy_1/strided_slice/stackpolicy_1/strided_slice/stack_1policy_1/strided_slice/stack_2*
Index0*
T0*

begin_mask*
ellipsis_mask *
end_mask*
new_axis_mask *
shrink_axis_mask 
;
policy_1/SoftmaxSoftmaxpolicy_1/dense/MatMul*
T0
;
policy_1/add/yConst*
dtype0*
valueB
 *���3
@
policy_1/addAddV2policy_1/Softmaxpolicy_1/add/y*
T0
B
policy_1/MulMulpolicy_1/addpolicy_1/strided_slice*
T0
H
policy_1/Sum/reduction_indicesConst*
dtype0*
value	B :
g
policy_1/SumSumpolicy_1/Mulpolicy_1/Sum/reduction_indices*
T0*

Tidx0*
	keep_dims(
@
policy_1/truedivRealDivpolicy_1/Mulpolicy_1/Sum*
T0
=
policy_1/add_1/yConst*
dtype0*
valueB
 *���3
D
policy_1/add_1AddV2policy_1/truedivpolicy_1/add_1/y*
T0
,
policy_1/LogLogpolicy_1/add_1*
T0
V
,policy_1/multinomial/Multinomial/num_samplesConst*
dtype0*
value	B :
�
 policy_1/multinomial/MultinomialMultinomialpolicy_1/Log,policy_1/multinomial/Multinomial/num_samples*
T0*
output_dtype0	*
seed�(*
seed2
D
policy_1/concat/concat_dimConst*
dtype0*
value	B :
M
policy_1/concat/concatIdentity policy_1/multinomial/Multinomial*
T0	
F
policy_1/concat_1/concat_dimConst*
dtype0*
value	B :
?
policy_1/concat_1/concatIdentitypolicy_1/truediv*
T0
=
policy_1/add_2/yConst*
dtype0*
valueB
 *���3
D
policy_1/add_2AddV2policy_1/truedivpolicy_1/add_2/y*
T0
.
policy_1/Log_1Logpolicy_1/add_2*
T0
F
policy_1/concat_2/concat_dimConst*
dtype0*
value	B :
=
policy_1/concat_2/concatIdentitypolicy_1/Log_1*
T0
S
policy_1/strided_slice_1/stackConst*
dtype0*
valueB"        
U
 policy_1/strided_slice_1/stack_1Const*
dtype0*
valueB"       
U
 policy_1/strided_slice_1/stack_2Const*
dtype0*
valueB"      
�
policy_1/strided_slice_1StridedSlicepolicy_1/concat/concatpolicy_1/strided_slice_1/stack policy_1/strided_slice_1/stack_1 policy_1/strided_slice_1/stack_2*
Index0*
T0	*

begin_mask*
ellipsis_mask *
end_mask*
new_axis_mask *
shrink_axis_mask
F
policy_1/one_hot/on_valueConst*
dtype0*
valueB
 *  �?
G
policy_1/one_hot/off_valueConst*
dtype0*
valueB
 *    
@
policy_1/one_hot/depthConst*
dtype0*
value	B :
�
policy_1/one_hotOneHotpolicy_1/strided_slice_1policy_1/one_hot/depthpolicy_1/one_hot/on_valuepolicy_1/one_hot/off_value*
T0*
TI0	*
axis���������
F
policy_1/concat_3/concat_dimConst*
dtype0*
value	B :
?
policy_1/concat_3/concatIdentitypolicy_1/one_hot*
T0
S
policy_1/strided_slice_2/stackConst*
dtype0*
valueB"        
U
 policy_1/strided_slice_2/stack_1Const*
dtype0*
valueB"       
U
 policy_1/strided_slice_2/stack_2Const*
dtype0*
valueB"      
�
policy_1/strided_slice_2StridedSlicepolicy_1/concat_2/concatpolicy_1/strided_slice_2/stack policy_1/strided_slice_2/stack_1 policy_1/strided_slice_2/stack_2*
Index0*
T0*

begin_mask*
ellipsis_mask *
end_mask*
new_axis_mask *
shrink_axis_mask 
@
policy_1/Softmax_1Softmaxpolicy_1/strided_slice_2*
T0
S
policy_1/strided_slice_3/stackConst*
dtype0*
valueB"        
U
 policy_1/strided_slice_3/stack_1Const*
dtype0*
valueB"       
U
 policy_1/strided_slice_3/stack_2Const*
dtype0*
valueB"      
�
policy_1/strided_slice_3StridedSlicepolicy_1/concat_2/concatpolicy_1/strided_slice_3/stack policy_1/strided_slice_3/stack_1 policy_1/strided_slice_3/stack_2*
Index0*
T0*

begin_mask*
ellipsis_mask *
end_mask*
new_axis_mask *
shrink_axis_mask 
Y
/policy_1/softmax_cross_entropy_with_logits/RankConst*
dtype0*
value	B :
l
0policy_1/softmax_cross_entropy_with_logits/ShapeShapepolicy_1/strided_slice_3*
T0*
out_type0
[
1policy_1/softmax_cross_entropy_with_logits/Rank_1Const*
dtype0*
value	B :
n
2policy_1/softmax_cross_entropy_with_logits/Shape_1Shapepolicy_1/strided_slice_3*
T0*
out_type0
Z
0policy_1/softmax_cross_entropy_with_logits/Sub/yConst*
dtype0*
value	B :
�
.policy_1/softmax_cross_entropy_with_logits/SubSub1policy_1/softmax_cross_entropy_with_logits/Rank_10policy_1/softmax_cross_entropy_with_logits/Sub/y*
T0
�
6policy_1/softmax_cross_entropy_with_logits/Slice/beginPack.policy_1/softmax_cross_entropy_with_logits/Sub*
N*
T0*

axis 
c
5policy_1/softmax_cross_entropy_with_logits/Slice/sizeConst*
dtype0*
valueB:
�
0policy_1/softmax_cross_entropy_with_logits/SliceSlice2policy_1/softmax_cross_entropy_with_logits/Shape_16policy_1/softmax_cross_entropy_with_logits/Slice/begin5policy_1/softmax_cross_entropy_with_logits/Slice/size*
Index0*
T0
q
:policy_1/softmax_cross_entropy_with_logits/concat/values_0Const*
dtype0*
valueB:
���������
`
6policy_1/softmax_cross_entropy_with_logits/concat/axisConst*
dtype0*
value	B : 
�
1policy_1/softmax_cross_entropy_with_logits/concatConcatV2:policy_1/softmax_cross_entropy_with_logits/concat/values_00policy_1/softmax_cross_entropy_with_logits/Slice6policy_1/softmax_cross_entropy_with_logits/concat/axis*
N*
T0*

Tidx0
�
2policy_1/softmax_cross_entropy_with_logits/ReshapeReshapepolicy_1/strided_slice_31policy_1/softmax_cross_entropy_with_logits/concat*
T0*
Tshape0
[
1policy_1/softmax_cross_entropy_with_logits/Rank_2Const*
dtype0*
value	B :
h
2policy_1/softmax_cross_entropy_with_logits/Shape_2Shapepolicy_1/Softmax_1*
T0*
out_type0
\
2policy_1/softmax_cross_entropy_with_logits/Sub_1/yConst*
dtype0*
value	B :
�
0policy_1/softmax_cross_entropy_with_logits/Sub_1Sub1policy_1/softmax_cross_entropy_with_logits/Rank_22policy_1/softmax_cross_entropy_with_logits/Sub_1/y*
T0
�
8policy_1/softmax_cross_entropy_with_logits/Slice_1/beginPack0policy_1/softmax_cross_entropy_with_logits/Sub_1*
N*
T0*

axis 
e
7policy_1/softmax_cross_entropy_with_logits/Slice_1/sizeConst*
dtype0*
valueB:
�
2policy_1/softmax_cross_entropy_with_logits/Slice_1Slice2policy_1/softmax_cross_entropy_with_logits/Shape_28policy_1/softmax_cross_entropy_with_logits/Slice_1/begin7policy_1/softmax_cross_entropy_with_logits/Slice_1/size*
Index0*
T0
s
<policy_1/softmax_cross_entropy_with_logits/concat_1/values_0Const*
dtype0*
valueB:
���������
b
8policy_1/softmax_cross_entropy_with_logits/concat_1/axisConst*
dtype0*
value	B : 
�
3policy_1/softmax_cross_entropy_with_logits/concat_1ConcatV2<policy_1/softmax_cross_entropy_with_logits/concat_1/values_02policy_1/softmax_cross_entropy_with_logits/Slice_18policy_1/softmax_cross_entropy_with_logits/concat_1/axis*
N*
T0*

Tidx0
�
4policy_1/softmax_cross_entropy_with_logits/Reshape_1Reshapepolicy_1/Softmax_13policy_1/softmax_cross_entropy_with_logits/concat_1*
T0*
Tshape0
�
*policy_1/softmax_cross_entropy_with_logitsSoftmaxCrossEntropyWithLogits2policy_1/softmax_cross_entropy_with_logits/Reshape4policy_1/softmax_cross_entropy_with_logits/Reshape_1*
T0
\
2policy_1/softmax_cross_entropy_with_logits/Sub_2/yConst*
dtype0*
value	B :
�
0policy_1/softmax_cross_entropy_with_logits/Sub_2Sub/policy_1/softmax_cross_entropy_with_logits/Rank2policy_1/softmax_cross_entropy_with_logits/Sub_2/y*
T0
f
8policy_1/softmax_cross_entropy_with_logits/Slice_2/beginConst*
dtype0*
valueB: 
�
7policy_1/softmax_cross_entropy_with_logits/Slice_2/sizePack0policy_1/softmax_cross_entropy_with_logits/Sub_2*
N*
T0*

axis 
�
2policy_1/softmax_cross_entropy_with_logits/Slice_2Slice0policy_1/softmax_cross_entropy_with_logits/Shape8policy_1/softmax_cross_entropy_with_logits/Slice_2/begin7policy_1/softmax_cross_entropy_with_logits/Slice_2/size*
Index0*
T0
�
4policy_1/softmax_cross_entropy_with_logits/Reshape_2Reshape*policy_1/softmax_cross_entropy_with_logits2policy_1/softmax_cross_entropy_with_logits/Slice_2*
T0*
Tshape0
j
policy_1/stackPack4policy_1/softmax_cross_entropy_with_logits/Reshape_2*
N*
T0*

axis
J
 policy_1/Sum_1/reduction_indicesConst*
dtype0*
value	B :
m
policy_1/Sum_1Sumpolicy_1/stack policy_1/Sum_1/reduction_indices*
T0*

Tidx0*
	keep_dims( 
S
policy_1/strided_slice_4/stackConst*
dtype0*
valueB"        
U
 policy_1/strided_slice_4/stack_1Const*
dtype0*
valueB"       
U
 policy_1/strided_slice_4/stack_2Const*
dtype0*
valueB"      
�
policy_1/strided_slice_4StridedSlicepolicy_1/concat_3/concatpolicy_1/strided_slice_4/stack policy_1/strided_slice_4/stack_1 policy_1/strided_slice_4/stack_2*
Index0*
T0*

begin_mask*
ellipsis_mask *
end_mask*
new_axis_mask *
shrink_axis_mask 
S
policy_1/strided_slice_5/stackConst*
dtype0*
valueB"        
U
 policy_1/strided_slice_5/stack_1Const*
dtype0*
valueB"       
U
 policy_1/strided_slice_5/stack_2Const*
dtype0*
valueB"      
�
policy_1/strided_slice_5StridedSlicepolicy_1/concat_2/concatpolicy_1/strided_slice_5/stack policy_1/strided_slice_5/stack_1 policy_1/strided_slice_5/stack_2*
Index0*
T0*

begin_mask*
ellipsis_mask *
end_mask*
new_axis_mask *
shrink_axis_mask 
[
1policy_1/softmax_cross_entropy_with_logits_1/RankConst*
dtype0*
value	B :
n
2policy_1/softmax_cross_entropy_with_logits_1/ShapeShapepolicy_1/strided_slice_5*
T0*
out_type0
]
3policy_1/softmax_cross_entropy_with_logits_1/Rank_1Const*
dtype0*
value	B :
p
4policy_1/softmax_cross_entropy_with_logits_1/Shape_1Shapepolicy_1/strided_slice_5*
T0*
out_type0
\
2policy_1/softmax_cross_entropy_with_logits_1/Sub/yConst*
dtype0*
value	B :
�
0policy_1/softmax_cross_entropy_with_logits_1/SubSub3policy_1/softmax_cross_entropy_with_logits_1/Rank_12policy_1/softmax_cross_entropy_with_logits_1/Sub/y*
T0
�
8policy_1/softmax_cross_entropy_with_logits_1/Slice/beginPack0policy_1/softmax_cross_entropy_with_logits_1/Sub*
N*
T0*

axis 
e
7policy_1/softmax_cross_entropy_with_logits_1/Slice/sizeConst*
dtype0*
valueB:
�
2policy_1/softmax_cross_entropy_with_logits_1/SliceSlice4policy_1/softmax_cross_entropy_with_logits_1/Shape_18policy_1/softmax_cross_entropy_with_logits_1/Slice/begin7policy_1/softmax_cross_entropy_with_logits_1/Slice/size*
Index0*
T0
s
<policy_1/softmax_cross_entropy_with_logits_1/concat/values_0Const*
dtype0*
valueB:
���������
b
8policy_1/softmax_cross_entropy_with_logits_1/concat/axisConst*
dtype0*
value	B : 
�
3policy_1/softmax_cross_entropy_with_logits_1/concatConcatV2<policy_1/softmax_cross_entropy_with_logits_1/concat/values_02policy_1/softmax_cross_entropy_with_logits_1/Slice8policy_1/softmax_cross_entropy_with_logits_1/concat/axis*
N*
T0*

Tidx0
�
4policy_1/softmax_cross_entropy_with_logits_1/ReshapeReshapepolicy_1/strided_slice_53policy_1/softmax_cross_entropy_with_logits_1/concat*
T0*
Tshape0
]
3policy_1/softmax_cross_entropy_with_logits_1/Rank_2Const*
dtype0*
value	B :
p
4policy_1/softmax_cross_entropy_with_logits_1/Shape_2Shapepolicy_1/strided_slice_4*
T0*
out_type0
^
4policy_1/softmax_cross_entropy_with_logits_1/Sub_1/yConst*
dtype0*
value	B :
�
2policy_1/softmax_cross_entropy_with_logits_1/Sub_1Sub3policy_1/softmax_cross_entropy_with_logits_1/Rank_24policy_1/softmax_cross_entropy_with_logits_1/Sub_1/y*
T0
�
:policy_1/softmax_cross_entropy_with_logits_1/Slice_1/beginPack2policy_1/softmax_cross_entropy_with_logits_1/Sub_1*
N*
T0*

axis 
g
9policy_1/softmax_cross_entropy_with_logits_1/Slice_1/sizeConst*
dtype0*
valueB:
�
4policy_1/softmax_cross_entropy_with_logits_1/Slice_1Slice4policy_1/softmax_cross_entropy_with_logits_1/Shape_2:policy_1/softmax_cross_entropy_with_logits_1/Slice_1/begin9policy_1/softmax_cross_entropy_with_logits_1/Slice_1/size*
Index0*
T0
u
>policy_1/softmax_cross_entropy_with_logits_1/concat_1/values_0Const*
dtype0*
valueB:
���������
d
:policy_1/softmax_cross_entropy_with_logits_1/concat_1/axisConst*
dtype0*
value	B : 
�
5policy_1/softmax_cross_entropy_with_logits_1/concat_1ConcatV2>policy_1/softmax_cross_entropy_with_logits_1/concat_1/values_04policy_1/softmax_cross_entropy_with_logits_1/Slice_1:policy_1/softmax_cross_entropy_with_logits_1/concat_1/axis*
N*
T0*

Tidx0
�
6policy_1/softmax_cross_entropy_with_logits_1/Reshape_1Reshapepolicy_1/strided_slice_45policy_1/softmax_cross_entropy_with_logits_1/concat_1*
T0*
Tshape0
�
,policy_1/softmax_cross_entropy_with_logits_1SoftmaxCrossEntropyWithLogits4policy_1/softmax_cross_entropy_with_logits_1/Reshape6policy_1/softmax_cross_entropy_with_logits_1/Reshape_1*
T0
^
4policy_1/softmax_cross_entropy_with_logits_1/Sub_2/yConst*
dtype0*
value	B :
�
2policy_1/softmax_cross_entropy_with_logits_1/Sub_2Sub1policy_1/softmax_cross_entropy_with_logits_1/Rank4policy_1/softmax_cross_entropy_with_logits_1/Sub_2/y*
T0
h
:policy_1/softmax_cross_entropy_with_logits_1/Slice_2/beginConst*
dtype0*
valueB: 
�
9policy_1/softmax_cross_entropy_with_logits_1/Slice_2/sizePack2policy_1/softmax_cross_entropy_with_logits_1/Sub_2*
N*
T0*

axis 
�
4policy_1/softmax_cross_entropy_with_logits_1/Slice_2Slice2policy_1/softmax_cross_entropy_with_logits_1/Shape:policy_1/softmax_cross_entropy_with_logits_1/Slice_2/begin9policy_1/softmax_cross_entropy_with_logits_1/Slice_2/size*
Index0*
T0
�
6policy_1/softmax_cross_entropy_with_logits_1/Reshape_2Reshape,policy_1/softmax_cross_entropy_with_logits_14policy_1/softmax_cross_entropy_with_logits_1/Slice_2*
T0*
Tshape0
T
policy_1/NegNeg6policy_1/softmax_cross_entropy_with_logits_1/Reshape_2*
T0
D
policy_1/stack_1Packpolicy_1/Neg*
N*
T0*

axis
J
 policy_1/Sum_2/reduction_indicesConst*
dtype0*
value	B :
o
policy_1/Sum_2Sumpolicy_1/stack_1 policy_1/Sum_2/reduction_indices*
T0*

Tidx0*
	keep_dims(
5
actionIdentitypolicy_1/concat_2/concat*
T0
?
StopGradientStopGradientpolicy_1/concat_3/concat*
T0
A
save/filename/inputConst*
dtype0*
valueB Bmodel
V
save/filenamePlaceholderWithDefaultsave/filename/input*
dtype0*
shape: 
M

save/ConstPlaceholderWithDefaultsave/filename*
dtype0*
shape: 
�
save/SaveV2/tensor_namesConst*
dtype0*�
value�B�Baction_output_shapeBglobal_stepBis_continuous_controlBmemory_sizeBnormalization_stepsBpolicy/dense/kernelB!policy/main_graph_0/hidden_0/biasB#policy/main_graph_0/hidden_0/kernelB!policy/main_graph_0/hidden_1/biasB#policy/main_graph_0/hidden_1/kernelBrunning_meanBrunning_varianceBtrainer_major_versionBtrainer_minor_versionBtrainer_patch_versionBversion_number
g
save/SaveV2/shape_and_slicesConst*
dtype0*3
value*B(B B B B B B B B B B B B B B B B 
�
save/SaveV2SaveV2
save/Constsave/SaveV2/tensor_namessave/SaveV2/shape_and_slicesaction_output_shapeglobal_stepis_continuous_controlmemory_sizenormalization_stepspolicy/dense/kernel!policy/main_graph_0/hidden_0/bias#policy/main_graph_0/hidden_0/kernel!policy/main_graph_0/hidden_1/bias#policy/main_graph_0/hidden_1/kernelrunning_meanrunning_variancetrainer_major_versiontrainer_minor_versiontrainer_patch_versionversion_number*
dtypes
2
e
save/control_dependencyIdentity
save/Const^save/SaveV2*
T0*
_class
loc:@save/Const
�
save/RestoreV2/tensor_namesConst"/device:CPU:0*
dtype0*�
value�B�Baction_output_shapeBglobal_stepBis_continuous_controlBmemory_sizeBnormalization_stepsBpolicy/dense/kernelB!policy/main_graph_0/hidden_0/biasB#policy/main_graph_0/hidden_0/kernelB!policy/main_graph_0/hidden_1/biasB#policy/main_graph_0/hidden_1/kernelBrunning_meanBrunning_varianceBtrainer_major_versionBtrainer_minor_versionBtrainer_patch_versionBversion_number
y
save/RestoreV2/shape_and_slicesConst"/device:CPU:0*
dtype0*3
value*B(B B B B B B B B B B B B B B B B 
�
save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices"/device:CPU:0*
dtypes
2
�
save/AssignAssignaction_output_shapesave/RestoreV2*
T0*&
_class
loc:@action_output_shape*
use_locking(*
validate_shape(
�
save/Assign_1Assignglobal_stepsave/RestoreV2:1*
T0*
_class
loc:@global_step*
use_locking(*
validate_shape(
�
save/Assign_2Assignis_continuous_controlsave/RestoreV2:2*
T0*(
_class
loc:@is_continuous_control*
use_locking(*
validate_shape(
�
save/Assign_3Assignmemory_sizesave/RestoreV2:3*
T0*
_class
loc:@memory_size*
use_locking(*
validate_shape(
�
save/Assign_4Assignnormalization_stepssave/RestoreV2:4*
T0*&
_class
loc:@normalization_steps*
use_locking(*
validate_shape(
�
save/Assign_5Assignpolicy/dense/kernelsave/RestoreV2:5*
T0*&
_class
loc:@policy/dense/kernel*
use_locking(*
validate_shape(
�
save/Assign_6Assign!policy/main_graph_0/hidden_0/biassave/RestoreV2:6*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
save/Assign_7Assign#policy/main_graph_0/hidden_0/kernelsave/RestoreV2:7*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
save/Assign_8Assign!policy/main_graph_0/hidden_1/biassave/RestoreV2:8*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
save/Assign_9Assign#policy/main_graph_0/hidden_1/kernelsave/RestoreV2:9*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
save/Assign_10Assignrunning_meansave/RestoreV2:10*
T0*
_class
loc:@running_mean*
use_locking(*
validate_shape(
�
save/Assign_11Assignrunning_variancesave/RestoreV2:11*
T0*#
_class
loc:@running_variance*
use_locking(*
validate_shape(
�
save/Assign_12Assigntrainer_major_versionsave/RestoreV2:12*
T0*(
_class
loc:@trainer_major_version*
use_locking(*
validate_shape(
�
save/Assign_13Assigntrainer_minor_versionsave/RestoreV2:13*
T0*(
_class
loc:@trainer_minor_version*
use_locking(*
validate_shape(
�
save/Assign_14Assigntrainer_patch_versionsave/RestoreV2:14*
T0*(
_class
loc:@trainer_patch_version*
use_locking(*
validate_shape(
�
save/Assign_15Assignversion_numbersave/RestoreV2:15*
T0*!
_class
loc:@version_number*
use_locking(*
validate_shape(
�
save/restore_allNoOp^save/Assign^save/Assign_1^save/Assign_10^save/Assign_11^save/Assign_12^save/Assign_13^save/Assign_14^save/Assign_15^save/Assign_2^save/Assign_3^save/Assign_4^save/Assign_5^save/Assign_6^save/Assign_7^save/Assign_8^save/Assign_9
�
initNoOp^action_output_shape/Assign^global_step/Assign^is_continuous_control/Assign^memory_size/Assign^normalization_steps/Assign^policy/dense/kernel/Assign)^policy/main_graph_0/hidden_0/bias/Assign+^policy/main_graph_0/hidden_0/kernel/Assign)^policy/main_graph_0/hidden_1/bias/Assign+^policy/main_graph_0/hidden_1/kernel/Assign^running_mean/Assign^running_variance/Assign^trainer_major_version/Assign^trainer_minor_version/Assign^trainer_patch_version/Assign^version_number/Assign
�
Joptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normal/shapeConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
dtype0*
valueB"   �   
�
Ioptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normal/meanConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
dtype0*
valueB
 *    
�
Koptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normal/stddevConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
dtype0*
valueB
 *���>
�
Toptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormalJoptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normal/shape*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
dtype0*
seed�(*
seed2
�
Hoptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normal/mulMulToptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormalKoptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normal/stddev*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel
�
Doptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normalAddHoptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normal/mulIoptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normal/mean*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel
�
'optimizer//main_graph_0/hidden_0/kernel
VariableV2*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
.optimizer//main_graph_0/hidden_0/kernel/AssignAssign'optimizer//main_graph_0/hidden_0/kernelDoptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normal*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
,optimizer//main_graph_0/hidden_0/kernel/readIdentity'optimizer//main_graph_0/hidden_0/kernel*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel
�
7optimizer//main_graph_0/hidden_0/bias/Initializer/zerosConst*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
dtype0*
valueB�*    
�
%optimizer//main_graph_0/hidden_0/bias
VariableV2*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
	container *
dtype0*
shape:�*
shared_name 
�
,optimizer//main_graph_0/hidden_0/bias/AssignAssign%optimizer//main_graph_0/hidden_0/bias7optimizer//main_graph_0/hidden_0/bias/Initializer/zeros*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
*optimizer//main_graph_0/hidden_0/bias/readIdentity%optimizer//main_graph_0/hidden_0/bias*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias
�
&optimizer/main_graph_0/hidden_0/MatMulMatMulnormalized_state,optimizer//main_graph_0/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
'optimizer/main_graph_0/hidden_0/BiasAddBiasAdd&optimizer/main_graph_0/hidden_0/MatMul*optimizer//main_graph_0/hidden_0/bias/read*
T0*
data_formatNHWC
d
'optimizer/main_graph_0/hidden_0/SigmoidSigmoid'optimizer/main_graph_0/hidden_0/BiasAdd*
T0
�
#optimizer/main_graph_0/hidden_0/MulMul'optimizer/main_graph_0/hidden_0/BiasAdd'optimizer/main_graph_0/hidden_0/Sigmoid*
T0
�
Joptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normal/shapeConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
dtype0*
valueB"�   �   
�
Ioptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normal/meanConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
dtype0*
valueB
 *    
�
Koptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normal/stddevConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
dtype0*
valueB
 *���=
�
Toptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormalJoptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normal/shape*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
dtype0*
seed�(*
seed2
�
Hoptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normal/mulMulToptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormalKoptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normal/stddev*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel
�
Doptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normalAddHoptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normal/mulIoptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normal/mean*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel
�
'optimizer//main_graph_0/hidden_1/kernel
VariableV2*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
.optimizer//main_graph_0/hidden_1/kernel/AssignAssign'optimizer//main_graph_0/hidden_1/kernelDoptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normal*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
,optimizer//main_graph_0/hidden_1/kernel/readIdentity'optimizer//main_graph_0/hidden_1/kernel*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel
�
7optimizer//main_graph_0/hidden_1/bias/Initializer/zerosConst*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
dtype0*
valueB�*    
�
%optimizer//main_graph_0/hidden_1/bias
VariableV2*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
	container *
dtype0*
shape:�*
shared_name 
�
,optimizer//main_graph_0/hidden_1/bias/AssignAssign%optimizer//main_graph_0/hidden_1/bias7optimizer//main_graph_0/hidden_1/bias/Initializer/zeros*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
*optimizer//main_graph_0/hidden_1/bias/readIdentity%optimizer//main_graph_0/hidden_1/bias*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias
�
&optimizer/main_graph_0/hidden_1/MatMulMatMul#optimizer/main_graph_0/hidden_0/Mul,optimizer//main_graph_0/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
'optimizer/main_graph_0/hidden_1/BiasAddBiasAdd&optimizer/main_graph_0/hidden_1/MatMul*optimizer//main_graph_0/hidden_1/bias/read*
T0*
data_formatNHWC
d
'optimizer/main_graph_0/hidden_1/SigmoidSigmoid'optimizer/main_graph_0/hidden_1/BiasAdd*
T0
�
#optimizer/main_graph_0/hidden_1/MulMul'optimizer/main_graph_0/hidden_1/BiasAdd'optimizer/main_graph_0/hidden_1/Sigmoid*
T0
�
Boptimizer//extrinsic_value/kernel/Initializer/random_uniform/shapeConst*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
dtype0*
valueB"�      
�
@optimizer//extrinsic_value/kernel/Initializer/random_uniform/minConst*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
dtype0*
valueB
 *n�\�
�
@optimizer//extrinsic_value/kernel/Initializer/random_uniform/maxConst*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
dtype0*
valueB
 *n�\>
�
Joptimizer//extrinsic_value/kernel/Initializer/random_uniform/RandomUniformRandomUniformBoptimizer//extrinsic_value/kernel/Initializer/random_uniform/shape*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
dtype0*
seed�(*
seed2
�
@optimizer//extrinsic_value/kernel/Initializer/random_uniform/subSub@optimizer//extrinsic_value/kernel/Initializer/random_uniform/max@optimizer//extrinsic_value/kernel/Initializer/random_uniform/min*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel
�
@optimizer//extrinsic_value/kernel/Initializer/random_uniform/mulMulJoptimizer//extrinsic_value/kernel/Initializer/random_uniform/RandomUniform@optimizer//extrinsic_value/kernel/Initializer/random_uniform/sub*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel
�
<optimizer//extrinsic_value/kernel/Initializer/random_uniformAdd@optimizer//extrinsic_value/kernel/Initializer/random_uniform/mul@optimizer//extrinsic_value/kernel/Initializer/random_uniform/min*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel
�
!optimizer//extrinsic_value/kernel
VariableV2*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
(optimizer//extrinsic_value/kernel/AssignAssign!optimizer//extrinsic_value/kernel<optimizer//extrinsic_value/kernel/Initializer/random_uniform*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
use_locking(*
validate_shape(
�
&optimizer//extrinsic_value/kernel/readIdentity!optimizer//extrinsic_value/kernel*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel
�
1optimizer//extrinsic_value/bias/Initializer/zerosConst*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
dtype0*
valueB*    
�
optimizer//extrinsic_value/bias
VariableV2*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
	container *
dtype0*
shape:*
shared_name 
�
&optimizer//extrinsic_value/bias/AssignAssignoptimizer//extrinsic_value/bias1optimizer//extrinsic_value/bias/Initializer/zeros*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
use_locking(*
validate_shape(
�
$optimizer//extrinsic_value/bias/readIdentityoptimizer//extrinsic_value/bias*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias
�
 optimizer/extrinsic_value/MatMulMatMul#optimizer/main_graph_0/hidden_1/Mul&optimizer//extrinsic_value/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
!optimizer/extrinsic_value/BiasAddBiasAdd optimizer/extrinsic_value/MatMul$optimizer//extrinsic_value/bias/read*
T0*
data_formatNHWC
]
optimizer/Mean/inputPack!optimizer/extrinsic_value/BiasAdd*
N*
T0*

axis 
J
 optimizer/Mean/reduction_indicesConst*
dtype0*
value	B : 
t
optimizer/MeanMeanoptimizer/Mean/input optimizer/Mean/reduction_indices*
T0*

Tidx0*
	keep_dims( 
U
optimizer/old_probabilitiesPlaceholder*
dtype0*
shape:���������
R
optimizer/strided_slice/stackConst*
dtype0*
valueB"        
T
optimizer/strided_slice/stack_1Const*
dtype0*
valueB"       
T
optimizer/strided_slice/stack_2Const*
dtype0*
valueB"      
�
optimizer/strided_sliceStridedSliceoptimizer/old_probabilitiesoptimizer/strided_slice/stackoptimizer/strided_slice/stack_1optimizer/strided_slice/stack_2*
Index0*
T0*

begin_mask*
ellipsis_mask *
end_mask*
new_axis_mask *
shrink_axis_mask 
T
optimizer/strided_slice_1/stackConst*
dtype0*
valueB"        
V
!optimizer/strided_slice_1/stack_1Const*
dtype0*
valueB"       
V
!optimizer/strided_slice_1/stack_2Const*
dtype0*
valueB"      
�
optimizer/strided_slice_1StridedSliceaction_masksoptimizer/strided_slice_1/stack!optimizer/strided_slice_1/stack_1!optimizer/strided_slice_1/stack_2*
Index0*
T0*

begin_mask*
ellipsis_mask *
end_mask*
new_axis_mask *
shrink_axis_mask 
>
optimizer/SoftmaxSoftmaxoptimizer/strided_slice*
T0
<
optimizer/add/yConst*
dtype0*
valueB
 *���3
C
optimizer/addAddV2optimizer/Softmaxoptimizer/add/y*
T0
G
optimizer/MulMuloptimizer/addoptimizer/strided_slice_1*
T0
I
optimizer/Sum/reduction_indicesConst*
dtype0*
value	B :
j
optimizer/SumSumoptimizer/Muloptimizer/Sum/reduction_indices*
T0*

Tidx0*
	keep_dims(
C
optimizer/truedivRealDivoptimizer/Muloptimizer/Sum*
T0
>
optimizer/add_1/yConst*
dtype0*
valueB
 *���3
G
optimizer/add_1AddV2optimizer/truedivoptimizer/add_1/y*
T0
.
optimizer/LogLogoptimizer/add_1*
T0
W
-optimizer/multinomial/Multinomial/num_samplesConst*
dtype0*
value	B :
�
!optimizer/multinomial/MultinomialMultinomialoptimizer/Log-optimizer/multinomial/Multinomial/num_samples*
T0*
output_dtype0	*
seed�(*
seed2
E
optimizer/concat/concat_dimConst*
dtype0*
value	B :
O
optimizer/concat/concatIdentity!optimizer/multinomial/Multinomial*
T0	
G
optimizer/concat_1/concat_dimConst*
dtype0*
value	B :
A
optimizer/concat_1/concatIdentityoptimizer/truediv*
T0
>
optimizer/add_2/yConst*
dtype0*
valueB
 *���3
G
optimizer/add_2AddV2optimizer/truedivoptimizer/add_2/y*
T0
0
optimizer/Log_1Logoptimizer/add_2*
T0
G
optimizer/concat_2/concat_dimConst*
dtype0*
value	B :
?
optimizer/concat_2/concatIdentityoptimizer/Log_1*
T0
T
optimizer/strided_slice_2/stackConst*
dtype0*
valueB"        
V
!optimizer/strided_slice_2/stack_1Const*
dtype0*
valueB"       
V
!optimizer/strided_slice_2/stack_2Const*
dtype0*
valueB"      
�
optimizer/strided_slice_2StridedSliceStopGradientoptimizer/strided_slice_2/stack!optimizer/strided_slice_2/stack_1!optimizer/strided_slice_2/stack_2*
Index0*
T0*

begin_mask*
ellipsis_mask *
end_mask*
new_axis_mask *
shrink_axis_mask 
T
optimizer/strided_slice_3/stackConst*
dtype0*
valueB"        
V
!optimizer/strided_slice_3/stack_1Const*
dtype0*
valueB"       
V
!optimizer/strided_slice_3/stack_2Const*
dtype0*
valueB"      
�
optimizer/strided_slice_3StridedSliceoptimizer/concat_2/concatoptimizer/strided_slice_3/stack!optimizer/strided_slice_3/stack_1!optimizer/strided_slice_3/stack_2*
Index0*
T0*

begin_mask*
ellipsis_mask *
end_mask*
new_axis_mask *
shrink_axis_mask 
Z
0optimizer/softmax_cross_entropy_with_logits/RankConst*
dtype0*
value	B :
n
1optimizer/softmax_cross_entropy_with_logits/ShapeShapeoptimizer/strided_slice_3*
T0*
out_type0
\
2optimizer/softmax_cross_entropy_with_logits/Rank_1Const*
dtype0*
value	B :
p
3optimizer/softmax_cross_entropy_with_logits/Shape_1Shapeoptimizer/strided_slice_3*
T0*
out_type0
[
1optimizer/softmax_cross_entropy_with_logits/Sub/yConst*
dtype0*
value	B :
�
/optimizer/softmax_cross_entropy_with_logits/SubSub2optimizer/softmax_cross_entropy_with_logits/Rank_11optimizer/softmax_cross_entropy_with_logits/Sub/y*
T0
�
7optimizer/softmax_cross_entropy_with_logits/Slice/beginPack/optimizer/softmax_cross_entropy_with_logits/Sub*
N*
T0*

axis 
d
6optimizer/softmax_cross_entropy_with_logits/Slice/sizeConst*
dtype0*
valueB:
�
1optimizer/softmax_cross_entropy_with_logits/SliceSlice3optimizer/softmax_cross_entropy_with_logits/Shape_17optimizer/softmax_cross_entropy_with_logits/Slice/begin6optimizer/softmax_cross_entropy_with_logits/Slice/size*
Index0*
T0
r
;optimizer/softmax_cross_entropy_with_logits/concat/values_0Const*
dtype0*
valueB:
���������
a
7optimizer/softmax_cross_entropy_with_logits/concat/axisConst*
dtype0*
value	B : 
�
2optimizer/softmax_cross_entropy_with_logits/concatConcatV2;optimizer/softmax_cross_entropy_with_logits/concat/values_01optimizer/softmax_cross_entropy_with_logits/Slice7optimizer/softmax_cross_entropy_with_logits/concat/axis*
N*
T0*

Tidx0
�
3optimizer/softmax_cross_entropy_with_logits/ReshapeReshapeoptimizer/strided_slice_32optimizer/softmax_cross_entropy_with_logits/concat*
T0*
Tshape0
\
2optimizer/softmax_cross_entropy_with_logits/Rank_2Const*
dtype0*
value	B :
p
3optimizer/softmax_cross_entropy_with_logits/Shape_2Shapeoptimizer/strided_slice_2*
T0*
out_type0
]
3optimizer/softmax_cross_entropy_with_logits/Sub_1/yConst*
dtype0*
value	B :
�
1optimizer/softmax_cross_entropy_with_logits/Sub_1Sub2optimizer/softmax_cross_entropy_with_logits/Rank_23optimizer/softmax_cross_entropy_with_logits/Sub_1/y*
T0
�
9optimizer/softmax_cross_entropy_with_logits/Slice_1/beginPack1optimizer/softmax_cross_entropy_with_logits/Sub_1*
N*
T0*

axis 
f
8optimizer/softmax_cross_entropy_with_logits/Slice_1/sizeConst*
dtype0*
valueB:
�
3optimizer/softmax_cross_entropy_with_logits/Slice_1Slice3optimizer/softmax_cross_entropy_with_logits/Shape_29optimizer/softmax_cross_entropy_with_logits/Slice_1/begin8optimizer/softmax_cross_entropy_with_logits/Slice_1/size*
Index0*
T0
t
=optimizer/softmax_cross_entropy_with_logits/concat_1/values_0Const*
dtype0*
valueB:
���������
c
9optimizer/softmax_cross_entropy_with_logits/concat_1/axisConst*
dtype0*
value	B : 
�
4optimizer/softmax_cross_entropy_with_logits/concat_1ConcatV2=optimizer/softmax_cross_entropy_with_logits/concat_1/values_03optimizer/softmax_cross_entropy_with_logits/Slice_19optimizer/softmax_cross_entropy_with_logits/concat_1/axis*
N*
T0*

Tidx0
�
5optimizer/softmax_cross_entropy_with_logits/Reshape_1Reshapeoptimizer/strided_slice_24optimizer/softmax_cross_entropy_with_logits/concat_1*
T0*
Tshape0
�
+optimizer/softmax_cross_entropy_with_logitsSoftmaxCrossEntropyWithLogits3optimizer/softmax_cross_entropy_with_logits/Reshape5optimizer/softmax_cross_entropy_with_logits/Reshape_1*
T0
]
3optimizer/softmax_cross_entropy_with_logits/Sub_2/yConst*
dtype0*
value	B :
�
1optimizer/softmax_cross_entropy_with_logits/Sub_2Sub0optimizer/softmax_cross_entropy_with_logits/Rank3optimizer/softmax_cross_entropy_with_logits/Sub_2/y*
T0
g
9optimizer/softmax_cross_entropy_with_logits/Slice_2/beginConst*
dtype0*
valueB: 
�
8optimizer/softmax_cross_entropy_with_logits/Slice_2/sizePack1optimizer/softmax_cross_entropy_with_logits/Sub_2*
N*
T0*

axis 
�
3optimizer/softmax_cross_entropy_with_logits/Slice_2Slice1optimizer/softmax_cross_entropy_with_logits/Shape9optimizer/softmax_cross_entropy_with_logits/Slice_2/begin8optimizer/softmax_cross_entropy_with_logits/Slice_2/size*
Index0*
T0
�
5optimizer/softmax_cross_entropy_with_logits/Reshape_2Reshape+optimizer/softmax_cross_entropy_with_logits3optimizer/softmax_cross_entropy_with_logits/Slice_2*
T0*
Tshape0
T
optimizer/NegNeg5optimizer/softmax_cross_entropy_with_logits/Reshape_2*
T0
D
optimizer/stackPackoptimizer/Neg*
N*
T0*

axis
K
!optimizer/Sum_1/reduction_indicesConst*
dtype0*
value	B :
p
optimizer/Sum_1Sumoptimizer/stack!optimizer/Sum_1/reduction_indices*
T0*

Tidx0*
	keep_dims(
\
/optimizer/PolynomialDecay/initial_learning_rateConst*
dtype0*
valueB
 *RI�9
M
 optimizer/PolynomialDecay/Cast/xConst*
dtype0*
valueB
 *���.
O
"optimizer/PolynomialDecay/Cast_1/xConst*
dtype0*
valueB
 *  �?
b
 optimizer/PolynomialDecay/Cast_2Castglobal_step/read*

DstT0*

SrcT0*
Truncate( 
N
"optimizer/PolynomialDecay/Cast_3/xConst*
dtype0*
valueB	 :��
t
 optimizer/PolynomialDecay/Cast_3Cast"optimizer/PolynomialDecay/Cast_3/x*

DstT0*

SrcT0*
Truncate( 
y
!optimizer/PolynomialDecay/MinimumMinimum optimizer/PolynomialDecay/Cast_2 optimizer/PolynomialDecay/Cast_3*
T0
z
!optimizer/PolynomialDecay/truedivRealDiv!optimizer/PolynomialDecay/Minimum optimizer/PolynomialDecay/Cast_3*
T0
�
optimizer/PolynomialDecay/subSub/optimizer/PolynomialDecay/initial_learning_rate optimizer/PolynomialDecay/Cast/x*
T0
N
!optimizer/PolynomialDecay/sub_1/xConst*
dtype0*
valueB
 *  �?
u
optimizer/PolynomialDecay/sub_1Sub!optimizer/PolynomialDecay/sub_1/x!optimizer/PolynomialDecay/truediv*
T0
r
optimizer/PolynomialDecay/PowPowoptimizer/PolynomialDecay/sub_1"optimizer/PolynomialDecay/Cast_1/x*
T0
k
optimizer/PolynomialDecay/MulMuloptimizer/PolynomialDecay/suboptimizer/PolynomialDecay/Pow*
T0
j
optimizer/PolynomialDecayAddoptimizer/PolynomialDecay/Mul optimizer/PolynomialDecay/Cast/x*
T0
Q
optimizer/extrinsic_returnsPlaceholder*
dtype0*
shape:���������
X
"optimizer/extrinsic_value_estimatePlaceholder*
dtype0*
shape:���������
J
optimizer/advantagesPlaceholder*
dtype0*
shape:���������
K
optimizer/ExpandDims/dimConst*
dtype0*
valueB :
���������
g
optimizer/ExpandDims
ExpandDimsoptimizer/advantagesoptimizer/ExpandDims/dim*
T0*

Tdim0
^
1optimizer/PolynomialDecay_1/initial_learning_rateConst*
dtype0*
valueB
 *��L>
O
"optimizer/PolynomialDecay_1/Cast/xConst*
dtype0*
valueB
 *���=
Q
$optimizer/PolynomialDecay_1/Cast_1/xConst*
dtype0*
valueB
 *  �?
d
"optimizer/PolynomialDecay_1/Cast_2Castglobal_step/read*

DstT0*

SrcT0*
Truncate( 
Q
$optimizer/PolynomialDecay_1/Cast_3/xConst*
dtype0*
valueB
 * $�H
�
#optimizer/PolynomialDecay_1/MinimumMinimum"optimizer/PolynomialDecay_1/Cast_2$optimizer/PolynomialDecay_1/Cast_3/x*
T0
�
#optimizer/PolynomialDecay_1/truedivRealDiv#optimizer/PolynomialDecay_1/Minimum$optimizer/PolynomialDecay_1/Cast_3/x*
T0
�
optimizer/PolynomialDecay_1/subSub1optimizer/PolynomialDecay_1/initial_learning_rate"optimizer/PolynomialDecay_1/Cast/x*
T0
P
#optimizer/PolynomialDecay_1/sub_1/xConst*
dtype0*
valueB
 *  �?
{
!optimizer/PolynomialDecay_1/sub_1Sub#optimizer/PolynomialDecay_1/sub_1/x#optimizer/PolynomialDecay_1/truediv*
T0
x
optimizer/PolynomialDecay_1/PowPow!optimizer/PolynomialDecay_1/sub_1$optimizer/PolynomialDecay_1/Cast_1/x*
T0
q
optimizer/PolynomialDecay_1/MulMuloptimizer/PolynomialDecay_1/suboptimizer/PolynomialDecay_1/Pow*
T0
p
optimizer/PolynomialDecay_1Addoptimizer/PolynomialDecay_1/Mul"optimizer/PolynomialDecay_1/Cast/x*
T0
^
1optimizer/PolynomialDecay_2/initial_learning_rateConst*
dtype0*
valueB
 *o�:
O
"optimizer/PolynomialDecay_2/Cast/xConst*
dtype0*
valueB
 *��'7
Q
$optimizer/PolynomialDecay_2/Cast_1/xConst*
dtype0*
valueB
 *  �?
d
"optimizer/PolynomialDecay_2/Cast_2Castglobal_step/read*

DstT0*

SrcT0*
Truncate( 
Q
$optimizer/PolynomialDecay_2/Cast_3/xConst*
dtype0*
valueB
 * $�H
�
#optimizer/PolynomialDecay_2/MinimumMinimum"optimizer/PolynomialDecay_2/Cast_2$optimizer/PolynomialDecay_2/Cast_3/x*
T0
�
#optimizer/PolynomialDecay_2/truedivRealDiv#optimizer/PolynomialDecay_2/Minimum$optimizer/PolynomialDecay_2/Cast_3/x*
T0
�
optimizer/PolynomialDecay_2/subSub1optimizer/PolynomialDecay_2/initial_learning_rate"optimizer/PolynomialDecay_2/Cast/x*
T0
P
#optimizer/PolynomialDecay_2/sub_1/xConst*
dtype0*
valueB
 *  �?
{
!optimizer/PolynomialDecay_2/sub_1Sub#optimizer/PolynomialDecay_2/sub_1/x#optimizer/PolynomialDecay_2/truediv*
T0
x
optimizer/PolynomialDecay_2/PowPow!optimizer/PolynomialDecay_2/sub_1$optimizer/PolynomialDecay_2/Cast_1/x*
T0
q
optimizer/PolynomialDecay_2/MulMuloptimizer/PolynomialDecay_2/suboptimizer/PolynomialDecay_2/Pow*
T0
p
optimizer/PolynomialDecay_2Addoptimizer/PolynomialDecay_2/Mul"optimizer/PolynomialDecay_2/Cast/x*
T0
K
!optimizer/Sum_2/reduction_indicesConst*
dtype0*
value	B :
�
optimizer/Sum_2Sum!optimizer/extrinsic_value/BiasAdd!optimizer/Sum_2/reduction_indices*
T0*

Tidx0*
	keep_dims( 
R
optimizer/subSuboptimizer/Sum_2"optimizer/extrinsic_value_estimate*
T0
<
optimizer/Neg_1Negoptimizer/PolynomialDecay_1*
T0
_
optimizer/clip_by_value/MinimumMinimumoptimizer/suboptimizer/PolynomialDecay_1*
T0
]
optimizer/clip_by_valueMaximumoptimizer/clip_by_value/Minimumoptimizer/Neg_1*
T0
^
optimizer/add_3AddV2"optimizer/extrinsic_value_estimateoptimizer/clip_by_value*
T0
K
!optimizer/Sum_3/reduction_indicesConst*
dtype0*
value	B :
�
optimizer/Sum_3Sum!optimizer/extrinsic_value/BiasAdd!optimizer/Sum_3/reduction_indices*
T0*

Tidx0*
	keep_dims( 
g
optimizer/SquaredDifferenceSquaredDifferenceoptimizer/extrinsic_returnsoptimizer/Sum_3*
T0
i
optimizer/SquaredDifference_1SquaredDifferenceoptimizer/extrinsic_returnsoptimizer/add_3*
T0
a
optimizer/MaximumMaximumoptimizer/SquaredDifferenceoptimizer/SquaredDifference_1*
T0
h
optimizer/DynamicPartitionDynamicPartitionoptimizer/MaximumCast_3*
T0*
num_partitions
=
optimizer/ConstConst*
dtype0*
valueB: 
m
optimizer/Mean_1Meanoptimizer/DynamicPartition:1optimizer/Const*
T0*

Tidx0*
	keep_dims( 
M
optimizer/Rank/packedPackoptimizer/Mean_1*
N*
T0*

axis 
8
optimizer/RankConst*
dtype0*
value	B :
?
optimizer/range/startConst*
dtype0*
value	B : 
?
optimizer/range/deltaConst*
dtype0*
value	B :
b
optimizer/rangeRangeoptimizer/range/startoptimizer/Rankoptimizer/range/delta*

Tidx0
N
optimizer/Mean_2/inputPackoptimizer/Mean_1*
N*
T0*

axis 
g
optimizer/Mean_2Meanoptimizer/Mean_2/inputoptimizer/range*
T0*

Tidx0*
	keep_dims( 
@
optimizer/sub_1Subpolicy_1/Sum_2optimizer/Sum_1*
T0
.
optimizer/ExpExpoptimizer/sub_1*
T0
D
optimizer/mul_1Muloptimizer/Expoptimizer/ExpandDims*
T0
>
optimizer/sub_2/xConst*
dtype0*
valueB
 *  �?
O
optimizer/sub_2Suboptimizer/sub_2/xoptimizer/PolynomialDecay_1*
T0
>
optimizer/add_4/xConst*
dtype0*
valueB
 *  �?
Q
optimizer/add_4AddV2optimizer/add_4/xoptimizer/PolynomialDecay_1*
T0
U
!optimizer/clip_by_value_1/MinimumMinimumoptimizer/Expoptimizer/add_4*
T0
a
optimizer/clip_by_value_1Maximum!optimizer/clip_by_value_1/Minimumoptimizer/sub_2*
T0
P
optimizer/mul_2Muloptimizer/clip_by_value_1optimizer/ExpandDims*
T0
G
optimizer/MinimumMinimumoptimizer/mul_1optimizer/mul_2*
T0
j
optimizer/DynamicPartition_1DynamicPartitionoptimizer/MinimumCast_3*
T0*
num_partitions
F
optimizer/Const_1Const*
dtype0*
valueB"       
q
optimizer/Mean_3Meanoptimizer/DynamicPartition_1:1optimizer/Const_1*
T0*

Tidx0*
	keep_dims( 
1
optimizer/Neg_2Negoptimizer/Mean_3*
T0
.
optimizer/AbsAbsoptimizer/Neg_2*
T0
>
optimizer/mul_3/xConst*
dtype0*
valueB
 *   ?
D
optimizer/mul_3Muloptimizer/mul_3/xoptimizer/Mean_2*
T0
C
optimizer/add_5AddV2optimizer/Neg_2optimizer/mul_3*
T0
g
optimizer/DynamicPartition_2DynamicPartitionpolicy_1/Sum_1Cast_3*
T0*
num_partitions
?
optimizer/Const_2Const*
dtype0*
valueB: 
q
optimizer/Mean_4Meanoptimizer/DynamicPartition_2:1optimizer/Const_2*
T0*

Tidx0*
	keep_dims( 
N
optimizer/mul_4Muloptimizer/PolynomialDecay_2optimizer/Mean_4*
T0
A
optimizer/sub_3Suboptimizer/add_5optimizer/mul_4*
T0
B
optimizer/gradients/ShapeConst*
dtype0*
valueB 
J
optimizer/gradients/grad_ys_0Const*
dtype0*
valueB
 *  �?
u
optimizer/gradients/FillFilloptimizer/gradients/Shapeoptimizer/gradients/grad_ys_0*
T0*

index_type0
V
,optimizer/gradients/optimizer/sub_3_grad/NegNegoptimizer/gradients/Fill*
T0
�
9optimizer/gradients/optimizer/sub_3_grad/tuple/group_depsNoOp^optimizer/gradients/Fill-^optimizer/gradients/optimizer/sub_3_grad/Neg
�
Aoptimizer/gradients/optimizer/sub_3_grad/tuple/control_dependencyIdentityoptimizer/gradients/Fill:^optimizer/gradients/optimizer/sub_3_grad/tuple/group_deps*
T0*+
_class!
loc:@optimizer/gradients/Fill
�
Coptimizer/gradients/optimizer/sub_3_grad/tuple/control_dependency_1Identity,optimizer/gradients/optimizer/sub_3_grad/Neg:^optimizer/gradients/optimizer/sub_3_grad/tuple/group_deps*
T0*?
_class5
31loc:@optimizer/gradients/optimizer/sub_3_grad/Neg
�
9optimizer/gradients/optimizer/add_5_grad/tuple/group_depsNoOpB^optimizer/gradients/optimizer/sub_3_grad/tuple/control_dependency
�
Aoptimizer/gradients/optimizer/add_5_grad/tuple/control_dependencyIdentityAoptimizer/gradients/optimizer/sub_3_grad/tuple/control_dependency:^optimizer/gradients/optimizer/add_5_grad/tuple/group_deps*
T0*+
_class!
loc:@optimizer/gradients/Fill
�
Coptimizer/gradients/optimizer/add_5_grad/tuple/control_dependency_1IdentityAoptimizer/gradients/optimizer/sub_3_grad/tuple/control_dependency:^optimizer/gradients/optimizer/add_5_grad/tuple/group_deps*
T0*+
_class!
loc:@optimizer/gradients/Fill
�
,optimizer/gradients/optimizer/mul_4_grad/MulMulCoptimizer/gradients/optimizer/sub_3_grad/tuple/control_dependency_1optimizer/Mean_4*
T0
�
.optimizer/gradients/optimizer/mul_4_grad/Mul_1MulCoptimizer/gradients/optimizer/sub_3_grad/tuple/control_dependency_1optimizer/PolynomialDecay_2*
T0
�
9optimizer/gradients/optimizer/mul_4_grad/tuple/group_depsNoOp-^optimizer/gradients/optimizer/mul_4_grad/Mul/^optimizer/gradients/optimizer/mul_4_grad/Mul_1
�
Aoptimizer/gradients/optimizer/mul_4_grad/tuple/control_dependencyIdentity,optimizer/gradients/optimizer/mul_4_grad/Mul:^optimizer/gradients/optimizer/mul_4_grad/tuple/group_deps*
T0*?
_class5
31loc:@optimizer/gradients/optimizer/mul_4_grad/Mul
�
Coptimizer/gradients/optimizer/mul_4_grad/tuple/control_dependency_1Identity.optimizer/gradients/optimizer/mul_4_grad/Mul_1:^optimizer/gradients/optimizer/mul_4_grad/tuple/group_deps*
T0*A
_class7
53loc:@optimizer/gradients/optimizer/mul_4_grad/Mul_1

,optimizer/gradients/optimizer/Neg_2_grad/NegNegAoptimizer/gradients/optimizer/add_5_grad/tuple/control_dependency*
T0
�
,optimizer/gradients/optimizer/mul_3_grad/MulMulCoptimizer/gradients/optimizer/add_5_grad/tuple/control_dependency_1optimizer/Mean_2*
T0
�
.optimizer/gradients/optimizer/mul_3_grad/Mul_1MulCoptimizer/gradients/optimizer/add_5_grad/tuple/control_dependency_1optimizer/mul_3/x*
T0
�
9optimizer/gradients/optimizer/mul_3_grad/tuple/group_depsNoOp-^optimizer/gradients/optimizer/mul_3_grad/Mul/^optimizer/gradients/optimizer/mul_3_grad/Mul_1
�
Aoptimizer/gradients/optimizer/mul_3_grad/tuple/control_dependencyIdentity,optimizer/gradients/optimizer/mul_3_grad/Mul:^optimizer/gradients/optimizer/mul_3_grad/tuple/group_deps*
T0*?
_class5
31loc:@optimizer/gradients/optimizer/mul_3_grad/Mul
�
Coptimizer/gradients/optimizer/mul_3_grad/tuple/control_dependency_1Identity.optimizer/gradients/optimizer/mul_3_grad/Mul_1:^optimizer/gradients/optimizer/mul_3_grad/tuple/group_deps*
T0*A
_class7
53loc:@optimizer/gradients/optimizer/mul_3_grad/Mul_1
e
7optimizer/gradients/optimizer/Mean_4_grad/Reshape/shapeConst*
dtype0*
valueB:
�
1optimizer/gradients/optimizer/Mean_4_grad/ReshapeReshapeCoptimizer/gradients/optimizer/mul_4_grad/tuple/control_dependency_17optimizer/gradients/optimizer/Mean_4_grad/Reshape/shape*
T0*
Tshape0
q
/optimizer/gradients/optimizer/Mean_4_grad/ShapeShapeoptimizer/DynamicPartition_2:1*
T0*
out_type0
�
.optimizer/gradients/optimizer/Mean_4_grad/TileTile1optimizer/gradients/optimizer/Mean_4_grad/Reshape/optimizer/gradients/optimizer/Mean_4_grad/Shape*
T0*

Tmultiples0
s
1optimizer/gradients/optimizer/Mean_4_grad/Shape_1Shapeoptimizer/DynamicPartition_2:1*
T0*
out_type0
Z
1optimizer/gradients/optimizer/Mean_4_grad/Shape_2Const*
dtype0*
valueB 
]
/optimizer/gradients/optimizer/Mean_4_grad/ConstConst*
dtype0*
valueB: 
�
.optimizer/gradients/optimizer/Mean_4_grad/ProdProd1optimizer/gradients/optimizer/Mean_4_grad/Shape_1/optimizer/gradients/optimizer/Mean_4_grad/Const*
T0*

Tidx0*
	keep_dims( 
_
1optimizer/gradients/optimizer/Mean_4_grad/Const_1Const*
dtype0*
valueB: 
�
0optimizer/gradients/optimizer/Mean_4_grad/Prod_1Prod1optimizer/gradients/optimizer/Mean_4_grad/Shape_21optimizer/gradients/optimizer/Mean_4_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
]
3optimizer/gradients/optimizer/Mean_4_grad/Maximum/yConst*
dtype0*
value	B :
�
1optimizer/gradients/optimizer/Mean_4_grad/MaximumMaximum0optimizer/gradients/optimizer/Mean_4_grad/Prod_13optimizer/gradients/optimizer/Mean_4_grad/Maximum/y*
T0
�
2optimizer/gradients/optimizer/Mean_4_grad/floordivFloorDiv.optimizer/gradients/optimizer/Mean_4_grad/Prod1optimizer/gradients/optimizer/Mean_4_grad/Maximum*
T0
�
.optimizer/gradients/optimizer/Mean_4_grad/CastCast2optimizer/gradients/optimizer/Mean_4_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
�
1optimizer/gradients/optimizer/Mean_4_grad/truedivRealDiv.optimizer/gradients/optimizer/Mean_4_grad/Tile.optimizer/gradients/optimizer/Mean_4_grad/Cast*
T0
l
7optimizer/gradients/optimizer/Mean_3_grad/Reshape/shapeConst*
dtype0*
valueB"      
�
1optimizer/gradients/optimizer/Mean_3_grad/ReshapeReshape,optimizer/gradients/optimizer/Neg_2_grad/Neg7optimizer/gradients/optimizer/Mean_3_grad/Reshape/shape*
T0*
Tshape0
q
/optimizer/gradients/optimizer/Mean_3_grad/ShapeShapeoptimizer/DynamicPartition_1:1*
T0*
out_type0
�
.optimizer/gradients/optimizer/Mean_3_grad/TileTile1optimizer/gradients/optimizer/Mean_3_grad/Reshape/optimizer/gradients/optimizer/Mean_3_grad/Shape*
T0*

Tmultiples0
s
1optimizer/gradients/optimizer/Mean_3_grad/Shape_1Shapeoptimizer/DynamicPartition_1:1*
T0*
out_type0
Z
1optimizer/gradients/optimizer/Mean_3_grad/Shape_2Const*
dtype0*
valueB 
]
/optimizer/gradients/optimizer/Mean_3_grad/ConstConst*
dtype0*
valueB: 
�
.optimizer/gradients/optimizer/Mean_3_grad/ProdProd1optimizer/gradients/optimizer/Mean_3_grad/Shape_1/optimizer/gradients/optimizer/Mean_3_grad/Const*
T0*

Tidx0*
	keep_dims( 
_
1optimizer/gradients/optimizer/Mean_3_grad/Const_1Const*
dtype0*
valueB: 
�
0optimizer/gradients/optimizer/Mean_3_grad/Prod_1Prod1optimizer/gradients/optimizer/Mean_3_grad/Shape_21optimizer/gradients/optimizer/Mean_3_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
]
3optimizer/gradients/optimizer/Mean_3_grad/Maximum/yConst*
dtype0*
value	B :
�
1optimizer/gradients/optimizer/Mean_3_grad/MaximumMaximum0optimizer/gradients/optimizer/Mean_3_grad/Prod_13optimizer/gradients/optimizer/Mean_3_grad/Maximum/y*
T0
�
2optimizer/gradients/optimizer/Mean_3_grad/floordivFloorDiv.optimizer/gradients/optimizer/Mean_3_grad/Prod1optimizer/gradients/optimizer/Mean_3_grad/Maximum*
T0
�
.optimizer/gradients/optimizer/Mean_3_grad/CastCast2optimizer/gradients/optimizer/Mean_3_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
�
1optimizer/gradients/optimizer/Mean_3_grad/truedivRealDiv.optimizer/gradients/optimizer/Mean_3_grad/Tile.optimizer/gradients/optimizer/Mean_3_grad/Cast*
T0
e
7optimizer/gradients/optimizer/Mean_2_grad/Reshape/shapeConst*
dtype0*
valueB:
�
1optimizer/gradients/optimizer/Mean_2_grad/ReshapeReshapeCoptimizer/gradients/optimizer/mul_3_grad/tuple/control_dependency_17optimizer/gradients/optimizer/Mean_2_grad/Reshape/shape*
T0*
Tshape0
]
/optimizer/gradients/optimizer/Mean_2_grad/ConstConst*
dtype0*
valueB:
�
.optimizer/gradients/optimizer/Mean_2_grad/TileTile1optimizer/gradients/optimizer/Mean_2_grad/Reshape/optimizer/gradients/optimizer/Mean_2_grad/Const*
T0*

Tmultiples0
^
1optimizer/gradients/optimizer/Mean_2_grad/Const_1Const*
dtype0*
valueB
 *  �?
�
1optimizer/gradients/optimizer/Mean_2_grad/truedivRealDiv.optimizer/gradients/optimizer/Mean_2_grad/Tile1optimizer/gradients/optimizer/Mean_2_grad/Const_1*
T0
R
optimizer/gradients/zeros_like	ZerosLikeoptimizer/DynamicPartition_2*
T0
e
;optimizer/gradients/optimizer/DynamicPartition_2_grad/ShapeShapeCast_3*
T0*
out_type0
i
;optimizer/gradients/optimizer/DynamicPartition_2_grad/ConstConst*
dtype0*
valueB: 
�
:optimizer/gradients/optimizer/DynamicPartition_2_grad/ProdProd;optimizer/gradients/optimizer/DynamicPartition_2_grad/Shape;optimizer/gradients/optimizer/DynamicPartition_2_grad/Const*
T0*

Tidx0*
	keep_dims( 
k
Aoptimizer/gradients/optimizer/DynamicPartition_2_grad/range/startConst*
dtype0*
value	B : 
k
Aoptimizer/gradients/optimizer/DynamicPartition_2_grad/range/deltaConst*
dtype0*
value	B :
�
;optimizer/gradients/optimizer/DynamicPartition_2_grad/rangeRangeAoptimizer/gradients/optimizer/DynamicPartition_2_grad/range/start:optimizer/gradients/optimizer/DynamicPartition_2_grad/ProdAoptimizer/gradients/optimizer/DynamicPartition_2_grad/range/delta*

Tidx0
�
=optimizer/gradients/optimizer/DynamicPartition_2_grad/ReshapeReshape;optimizer/gradients/optimizer/DynamicPartition_2_grad/range;optimizer/gradients/optimizer/DynamicPartition_2_grad/Shape*
T0*
Tshape0
�
Foptimizer/gradients/optimizer/DynamicPartition_2_grad/DynamicPartitionDynamicPartition=optimizer/gradients/optimizer/DynamicPartition_2_grad/ReshapeCast_3*
T0*
num_partitions
�
Koptimizer/gradients/optimizer/DynamicPartition_2_grad/ParallelDynamicStitchParallelDynamicStitchFoptimizer/gradients/optimizer/DynamicPartition_2_grad/DynamicPartitionHoptimizer/gradients/optimizer/DynamicPartition_2_grad/DynamicPartition:1optimizer/gradients/zeros_like1optimizer/gradients/optimizer/Mean_4_grad/truediv*
N*
T0
o
=optimizer/gradients/optimizer/DynamicPartition_2_grad/Shape_1Shapepolicy_1/Sum_1*
T0*
out_type0
�
?optimizer/gradients/optimizer/DynamicPartition_2_grad/Reshape_1ReshapeKoptimizer/gradients/optimizer/DynamicPartition_2_grad/ParallelDynamicStitch=optimizer/gradients/optimizer/DynamicPartition_2_grad/Shape_1*
T0*
Tshape0
T
 optimizer/gradients/zeros_like_1	ZerosLikeoptimizer/DynamicPartition_1*
T0
e
;optimizer/gradients/optimizer/DynamicPartition_1_grad/ShapeShapeCast_3*
T0*
out_type0
i
;optimizer/gradients/optimizer/DynamicPartition_1_grad/ConstConst*
dtype0*
valueB: 
�
:optimizer/gradients/optimizer/DynamicPartition_1_grad/ProdProd;optimizer/gradients/optimizer/DynamicPartition_1_grad/Shape;optimizer/gradients/optimizer/DynamicPartition_1_grad/Const*
T0*

Tidx0*
	keep_dims( 
k
Aoptimizer/gradients/optimizer/DynamicPartition_1_grad/range/startConst*
dtype0*
value	B : 
k
Aoptimizer/gradients/optimizer/DynamicPartition_1_grad/range/deltaConst*
dtype0*
value	B :
�
;optimizer/gradients/optimizer/DynamicPartition_1_grad/rangeRangeAoptimizer/gradients/optimizer/DynamicPartition_1_grad/range/start:optimizer/gradients/optimizer/DynamicPartition_1_grad/ProdAoptimizer/gradients/optimizer/DynamicPartition_1_grad/range/delta*

Tidx0
�
=optimizer/gradients/optimizer/DynamicPartition_1_grad/ReshapeReshape;optimizer/gradients/optimizer/DynamicPartition_1_grad/range;optimizer/gradients/optimizer/DynamicPartition_1_grad/Shape*
T0*
Tshape0
�
Foptimizer/gradients/optimizer/DynamicPartition_1_grad/DynamicPartitionDynamicPartition=optimizer/gradients/optimizer/DynamicPartition_1_grad/ReshapeCast_3*
T0*
num_partitions
�
Koptimizer/gradients/optimizer/DynamicPartition_1_grad/ParallelDynamicStitchParallelDynamicStitchFoptimizer/gradients/optimizer/DynamicPartition_1_grad/DynamicPartitionHoptimizer/gradients/optimizer/DynamicPartition_1_grad/DynamicPartition:1 optimizer/gradients/zeros_like_11optimizer/gradients/optimizer/Mean_3_grad/truediv*
N*
T0
r
=optimizer/gradients/optimizer/DynamicPartition_1_grad/Shape_1Shapeoptimizer/Minimum*
T0*
out_type0
�
?optimizer/gradients/optimizer/DynamicPartition_1_grad/Reshape_1ReshapeKoptimizer/gradients/optimizer/DynamicPartition_1_grad/ParallelDynamicStitch=optimizer/gradients/optimizer/DynamicPartition_1_grad/Shape_1*
T0*
Tshape0
�
7optimizer/gradients/optimizer/Mean_2/input_grad/unstackUnpack1optimizer/gradients/optimizer/Mean_2_grad/truediv*
T0*

axis *	
num
_
-optimizer/gradients/policy_1/Sum_1_grad/ShapeShapepolicy_1/stack*
T0*
out_type0
�
,optimizer/gradients/policy_1/Sum_1_grad/SizeConst*@
_class6
42loc:@optimizer/gradients/policy_1/Sum_1_grad/Shape*
dtype0*
value	B :
�
+optimizer/gradients/policy_1/Sum_1_grad/addAddV2 policy_1/Sum_1/reduction_indices,optimizer/gradients/policy_1/Sum_1_grad/Size*
T0*@
_class6
42loc:@optimizer/gradients/policy_1/Sum_1_grad/Shape
�
+optimizer/gradients/policy_1/Sum_1_grad/modFloorMod+optimizer/gradients/policy_1/Sum_1_grad/add,optimizer/gradients/policy_1/Sum_1_grad/Size*
T0*@
_class6
42loc:@optimizer/gradients/policy_1/Sum_1_grad/Shape
�
/optimizer/gradients/policy_1/Sum_1_grad/Shape_1Const*@
_class6
42loc:@optimizer/gradients/policy_1/Sum_1_grad/Shape*
dtype0*
valueB 
�
3optimizer/gradients/policy_1/Sum_1_grad/range/startConst*@
_class6
42loc:@optimizer/gradients/policy_1/Sum_1_grad/Shape*
dtype0*
value	B : 
�
3optimizer/gradients/policy_1/Sum_1_grad/range/deltaConst*@
_class6
42loc:@optimizer/gradients/policy_1/Sum_1_grad/Shape*
dtype0*
value	B :
�
-optimizer/gradients/policy_1/Sum_1_grad/rangeRange3optimizer/gradients/policy_1/Sum_1_grad/range/start,optimizer/gradients/policy_1/Sum_1_grad/Size3optimizer/gradients/policy_1/Sum_1_grad/range/delta*

Tidx0*@
_class6
42loc:@optimizer/gradients/policy_1/Sum_1_grad/Shape
�
2optimizer/gradients/policy_1/Sum_1_grad/Fill/valueConst*@
_class6
42loc:@optimizer/gradients/policy_1/Sum_1_grad/Shape*
dtype0*
value	B :
�
,optimizer/gradients/policy_1/Sum_1_grad/FillFill/optimizer/gradients/policy_1/Sum_1_grad/Shape_12optimizer/gradients/policy_1/Sum_1_grad/Fill/value*
T0*@
_class6
42loc:@optimizer/gradients/policy_1/Sum_1_grad/Shape*

index_type0
�
5optimizer/gradients/policy_1/Sum_1_grad/DynamicStitchDynamicStitch-optimizer/gradients/policy_1/Sum_1_grad/range+optimizer/gradients/policy_1/Sum_1_grad/mod-optimizer/gradients/policy_1/Sum_1_grad/Shape,optimizer/gradients/policy_1/Sum_1_grad/Fill*
N*
T0*@
_class6
42loc:@optimizer/gradients/policy_1/Sum_1_grad/Shape
�
/optimizer/gradients/policy_1/Sum_1_grad/ReshapeReshape?optimizer/gradients/optimizer/DynamicPartition_2_grad/Reshape_15optimizer/gradients/policy_1/Sum_1_grad/DynamicStitch*
T0*
Tshape0
�
3optimizer/gradients/policy_1/Sum_1_grad/BroadcastToBroadcastTo/optimizer/gradients/policy_1/Sum_1_grad/Reshape-optimizer/gradients/policy_1/Sum_1_grad/Shape*
T0*

Tidx0
c
0optimizer/gradients/optimizer/Minimum_grad/ShapeShapeoptimizer/mul_1*
T0*
out_type0
e
2optimizer/gradients/optimizer/Minimum_grad/Shape_1Shapeoptimizer/mul_2*
T0*
out_type0
�
2optimizer/gradients/optimizer/Minimum_grad/Shape_2Shape?optimizer/gradients/optimizer/DynamicPartition_1_grad/Reshape_1*
T0*
out_type0
c
6optimizer/gradients/optimizer/Minimum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
0optimizer/gradients/optimizer/Minimum_grad/zerosFill2optimizer/gradients/optimizer/Minimum_grad/Shape_26optimizer/gradients/optimizer/Minimum_grad/zeros/Const*
T0*

index_type0
l
4optimizer/gradients/optimizer/Minimum_grad/LessEqual	LessEqualoptimizer/mul_1optimizer/mul_2*
T0
�
@optimizer/gradients/optimizer/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs0optimizer/gradients/optimizer/Minimum_grad/Shape2optimizer/gradients/optimizer/Minimum_grad/Shape_1*
T0
�
3optimizer/gradients/optimizer/Minimum_grad/SelectV2SelectV24optimizer/gradients/optimizer/Minimum_grad/LessEqual?optimizer/gradients/optimizer/DynamicPartition_1_grad/Reshape_10optimizer/gradients/optimizer/Minimum_grad/zeros*
T0
�
.optimizer/gradients/optimizer/Minimum_grad/SumSum3optimizer/gradients/optimizer/Minimum_grad/SelectV2@optimizer/gradients/optimizer/Minimum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients/optimizer/Minimum_grad/ReshapeReshape.optimizer/gradients/optimizer/Minimum_grad/Sum0optimizer/gradients/optimizer/Minimum_grad/Shape*
T0*
Tshape0
�
5optimizer/gradients/optimizer/Minimum_grad/SelectV2_1SelectV24optimizer/gradients/optimizer/Minimum_grad/LessEqual0optimizer/gradients/optimizer/Minimum_grad/zeros?optimizer/gradients/optimizer/DynamicPartition_1_grad/Reshape_1*
T0
�
0optimizer/gradients/optimizer/Minimum_grad/Sum_1Sum5optimizer/gradients/optimizer/Minimum_grad/SelectV2_1Boptimizer/gradients/optimizer/Minimum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients/optimizer/Minimum_grad/Reshape_1Reshape0optimizer/gradients/optimizer/Minimum_grad/Sum_12optimizer/gradients/optimizer/Minimum_grad/Shape_1*
T0*
Tshape0
�
;optimizer/gradients/optimizer/Minimum_grad/tuple/group_depsNoOp3^optimizer/gradients/optimizer/Minimum_grad/Reshape5^optimizer/gradients/optimizer/Minimum_grad/Reshape_1
�
Coptimizer/gradients/optimizer/Minimum_grad/tuple/control_dependencyIdentity2optimizer/gradients/optimizer/Minimum_grad/Reshape<^optimizer/gradients/optimizer/Minimum_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients/optimizer/Minimum_grad/Reshape
�
Eoptimizer/gradients/optimizer/Minimum_grad/tuple/control_dependency_1Identity4optimizer/gradients/optimizer/Minimum_grad/Reshape_1<^optimizer/gradients/optimizer/Minimum_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients/optimizer/Minimum_grad/Reshape_1
e
7optimizer/gradients/optimizer/Mean_1_grad/Reshape/shapeConst*
dtype0*
valueB:
�
1optimizer/gradients/optimizer/Mean_1_grad/ReshapeReshape7optimizer/gradients/optimizer/Mean_2/input_grad/unstack7optimizer/gradients/optimizer/Mean_1_grad/Reshape/shape*
T0*
Tshape0
o
/optimizer/gradients/optimizer/Mean_1_grad/ShapeShapeoptimizer/DynamicPartition:1*
T0*
out_type0
�
.optimizer/gradients/optimizer/Mean_1_grad/TileTile1optimizer/gradients/optimizer/Mean_1_grad/Reshape/optimizer/gradients/optimizer/Mean_1_grad/Shape*
T0*

Tmultiples0
q
1optimizer/gradients/optimizer/Mean_1_grad/Shape_1Shapeoptimizer/DynamicPartition:1*
T0*
out_type0
Z
1optimizer/gradients/optimizer/Mean_1_grad/Shape_2Const*
dtype0*
valueB 
]
/optimizer/gradients/optimizer/Mean_1_grad/ConstConst*
dtype0*
valueB: 
�
.optimizer/gradients/optimizer/Mean_1_grad/ProdProd1optimizer/gradients/optimizer/Mean_1_grad/Shape_1/optimizer/gradients/optimizer/Mean_1_grad/Const*
T0*

Tidx0*
	keep_dims( 
_
1optimizer/gradients/optimizer/Mean_1_grad/Const_1Const*
dtype0*
valueB: 
�
0optimizer/gradients/optimizer/Mean_1_grad/Prod_1Prod1optimizer/gradients/optimizer/Mean_1_grad/Shape_21optimizer/gradients/optimizer/Mean_1_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
]
3optimizer/gradients/optimizer/Mean_1_grad/Maximum/yConst*
dtype0*
value	B :
�
1optimizer/gradients/optimizer/Mean_1_grad/MaximumMaximum0optimizer/gradients/optimizer/Mean_1_grad/Prod_13optimizer/gradients/optimizer/Mean_1_grad/Maximum/y*
T0
�
2optimizer/gradients/optimizer/Mean_1_grad/floordivFloorDiv.optimizer/gradients/optimizer/Mean_1_grad/Prod1optimizer/gradients/optimizer/Mean_1_grad/Maximum*
T0
�
.optimizer/gradients/optimizer/Mean_1_grad/CastCast2optimizer/gradients/optimizer/Mean_1_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
�
1optimizer/gradients/optimizer/Mean_1_grad/truedivRealDiv.optimizer/gradients/optimizer/Mean_1_grad/Tile.optimizer/gradients/optimizer/Mean_1_grad/Cast*
T0
�
/optimizer/gradients/policy_1/stack_grad/unstackUnpack3optimizer/gradients/policy_1/Sum_1_grad/BroadcastTo*
T0*

axis*	
num
_
.optimizer/gradients/optimizer/mul_1_grad/ShapeShapeoptimizer/Exp*
T0*
out_type0
h
0optimizer/gradients/optimizer/mul_1_grad/Shape_1Shapeoptimizer/ExpandDims*
T0*
out_type0
�
>optimizer/gradients/optimizer/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgs.optimizer/gradients/optimizer/mul_1_grad/Shape0optimizer/gradients/optimizer/mul_1_grad/Shape_1*
T0
�
,optimizer/gradients/optimizer/mul_1_grad/MulMulCoptimizer/gradients/optimizer/Minimum_grad/tuple/control_dependencyoptimizer/ExpandDims*
T0
�
,optimizer/gradients/optimizer/mul_1_grad/SumSum,optimizer/gradients/optimizer/mul_1_grad/Mul>optimizer/gradients/optimizer/mul_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
0optimizer/gradients/optimizer/mul_1_grad/ReshapeReshape,optimizer/gradients/optimizer/mul_1_grad/Sum.optimizer/gradients/optimizer/mul_1_grad/Shape*
T0*
Tshape0
�
.optimizer/gradients/optimizer/mul_1_grad/Mul_1Muloptimizer/ExpCoptimizer/gradients/optimizer/Minimum_grad/tuple/control_dependency*
T0
�
.optimizer/gradients/optimizer/mul_1_grad/Sum_1Sum.optimizer/gradients/optimizer/mul_1_grad/Mul_1@optimizer/gradients/optimizer/mul_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients/optimizer/mul_1_grad/Reshape_1Reshape.optimizer/gradients/optimizer/mul_1_grad/Sum_10optimizer/gradients/optimizer/mul_1_grad/Shape_1*
T0*
Tshape0
�
9optimizer/gradients/optimizer/mul_1_grad/tuple/group_depsNoOp1^optimizer/gradients/optimizer/mul_1_grad/Reshape3^optimizer/gradients/optimizer/mul_1_grad/Reshape_1
�
Aoptimizer/gradients/optimizer/mul_1_grad/tuple/control_dependencyIdentity0optimizer/gradients/optimizer/mul_1_grad/Reshape:^optimizer/gradients/optimizer/mul_1_grad/tuple/group_deps*
T0*C
_class9
75loc:@optimizer/gradients/optimizer/mul_1_grad/Reshape
�
Coptimizer/gradients/optimizer/mul_1_grad/tuple/control_dependency_1Identity2optimizer/gradients/optimizer/mul_1_grad/Reshape_1:^optimizer/gradients/optimizer/mul_1_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients/optimizer/mul_1_grad/Reshape_1
k
.optimizer/gradients/optimizer/mul_2_grad/ShapeShapeoptimizer/clip_by_value_1*
T0*
out_type0
h
0optimizer/gradients/optimizer/mul_2_grad/Shape_1Shapeoptimizer/ExpandDims*
T0*
out_type0
�
>optimizer/gradients/optimizer/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgs.optimizer/gradients/optimizer/mul_2_grad/Shape0optimizer/gradients/optimizer/mul_2_grad/Shape_1*
T0
�
,optimizer/gradients/optimizer/mul_2_grad/MulMulEoptimizer/gradients/optimizer/Minimum_grad/tuple/control_dependency_1optimizer/ExpandDims*
T0
�
,optimizer/gradients/optimizer/mul_2_grad/SumSum,optimizer/gradients/optimizer/mul_2_grad/Mul>optimizer/gradients/optimizer/mul_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
0optimizer/gradients/optimizer/mul_2_grad/ReshapeReshape,optimizer/gradients/optimizer/mul_2_grad/Sum.optimizer/gradients/optimizer/mul_2_grad/Shape*
T0*
Tshape0
�
.optimizer/gradients/optimizer/mul_2_grad/Mul_1Muloptimizer/clip_by_value_1Eoptimizer/gradients/optimizer/Minimum_grad/tuple/control_dependency_1*
T0
�
.optimizer/gradients/optimizer/mul_2_grad/Sum_1Sum.optimizer/gradients/optimizer/mul_2_grad/Mul_1@optimizer/gradients/optimizer/mul_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients/optimizer/mul_2_grad/Reshape_1Reshape.optimizer/gradients/optimizer/mul_2_grad/Sum_10optimizer/gradients/optimizer/mul_2_grad/Shape_1*
T0*
Tshape0
�
9optimizer/gradients/optimizer/mul_2_grad/tuple/group_depsNoOp1^optimizer/gradients/optimizer/mul_2_grad/Reshape3^optimizer/gradients/optimizer/mul_2_grad/Reshape_1
�
Aoptimizer/gradients/optimizer/mul_2_grad/tuple/control_dependencyIdentity0optimizer/gradients/optimizer/mul_2_grad/Reshape:^optimizer/gradients/optimizer/mul_2_grad/tuple/group_deps*
T0*C
_class9
75loc:@optimizer/gradients/optimizer/mul_2_grad/Reshape
�
Coptimizer/gradients/optimizer/mul_2_grad/tuple/control_dependency_1Identity2optimizer/gradients/optimizer/mul_2_grad/Reshape_1:^optimizer/gradients/optimizer/mul_2_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients/optimizer/mul_2_grad/Reshape_1
R
 optimizer/gradients/zeros_like_2	ZerosLikeoptimizer/DynamicPartition*
T0
c
9optimizer/gradients/optimizer/DynamicPartition_grad/ShapeShapeCast_3*
T0*
out_type0
g
9optimizer/gradients/optimizer/DynamicPartition_grad/ConstConst*
dtype0*
valueB: 
�
8optimizer/gradients/optimizer/DynamicPartition_grad/ProdProd9optimizer/gradients/optimizer/DynamicPartition_grad/Shape9optimizer/gradients/optimizer/DynamicPartition_grad/Const*
T0*

Tidx0*
	keep_dims( 
i
?optimizer/gradients/optimizer/DynamicPartition_grad/range/startConst*
dtype0*
value	B : 
i
?optimizer/gradients/optimizer/DynamicPartition_grad/range/deltaConst*
dtype0*
value	B :
�
9optimizer/gradients/optimizer/DynamicPartition_grad/rangeRange?optimizer/gradients/optimizer/DynamicPartition_grad/range/start8optimizer/gradients/optimizer/DynamicPartition_grad/Prod?optimizer/gradients/optimizer/DynamicPartition_grad/range/delta*

Tidx0
�
;optimizer/gradients/optimizer/DynamicPartition_grad/ReshapeReshape9optimizer/gradients/optimizer/DynamicPartition_grad/range9optimizer/gradients/optimizer/DynamicPartition_grad/Shape*
T0*
Tshape0
�
Doptimizer/gradients/optimizer/DynamicPartition_grad/DynamicPartitionDynamicPartition;optimizer/gradients/optimizer/DynamicPartition_grad/ReshapeCast_3*
T0*
num_partitions
�
Ioptimizer/gradients/optimizer/DynamicPartition_grad/ParallelDynamicStitchParallelDynamicStitchDoptimizer/gradients/optimizer/DynamicPartition_grad/DynamicPartitionFoptimizer/gradients/optimizer/DynamicPartition_grad/DynamicPartition:1 optimizer/gradients/zeros_like_21optimizer/gradients/optimizer/Mean_1_grad/truediv*
N*
T0
p
;optimizer/gradients/optimizer/DynamicPartition_grad/Shape_1Shapeoptimizer/Maximum*
T0*
out_type0
�
=optimizer/gradients/optimizer/DynamicPartition_grad/Reshape_1ReshapeIoptimizer/gradients/optimizer/DynamicPartition_grad/ParallelDynamicStitch;optimizer/gradients/optimizer/DynamicPartition_grad/Shape_1*
T0*
Tshape0
�
Soptimizer/gradients/policy_1/softmax_cross_entropy_with_logits/Reshape_2_grad/ShapeShape*policy_1/softmax_cross_entropy_with_logits*
T0*
out_type0
�
Uoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits/Reshape_2_grad/ReshapeReshape/optimizer/gradients/policy_1/stack_grad/unstackSoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits/Reshape_2_grad/Shape*
T0*
Tshape0
}
8optimizer/gradients/optimizer/clip_by_value_1_grad/ShapeShape!optimizer/clip_by_value_1/Minimum*
T0*
out_type0
c
:optimizer/gradients/optimizer/clip_by_value_1_grad/Shape_1Const*
dtype0*
valueB 
�
:optimizer/gradients/optimizer/clip_by_value_1_grad/Shape_2ShapeAoptimizer/gradients/optimizer/mul_2_grad/tuple/control_dependency*
T0*
out_type0
k
>optimizer/gradients/optimizer/clip_by_value_1_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
8optimizer/gradients/optimizer/clip_by_value_1_grad/zerosFill:optimizer/gradients/optimizer/clip_by_value_1_grad/Shape_2>optimizer/gradients/optimizer/clip_by_value_1_grad/zeros/Const*
T0*

index_type0
�
?optimizer/gradients/optimizer/clip_by_value_1_grad/GreaterEqualGreaterEqual!optimizer/clip_by_value_1/Minimumoptimizer/sub_2*
T0
�
Hoptimizer/gradients/optimizer/clip_by_value_1_grad/BroadcastGradientArgsBroadcastGradientArgs8optimizer/gradients/optimizer/clip_by_value_1_grad/Shape:optimizer/gradients/optimizer/clip_by_value_1_grad/Shape_1*
T0
�
;optimizer/gradients/optimizer/clip_by_value_1_grad/SelectV2SelectV2?optimizer/gradients/optimizer/clip_by_value_1_grad/GreaterEqualAoptimizer/gradients/optimizer/mul_2_grad/tuple/control_dependency8optimizer/gradients/optimizer/clip_by_value_1_grad/zeros*
T0
�
6optimizer/gradients/optimizer/clip_by_value_1_grad/SumSum;optimizer/gradients/optimizer/clip_by_value_1_grad/SelectV2Hoptimizer/gradients/optimizer/clip_by_value_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
:optimizer/gradients/optimizer/clip_by_value_1_grad/ReshapeReshape6optimizer/gradients/optimizer/clip_by_value_1_grad/Sum8optimizer/gradients/optimizer/clip_by_value_1_grad/Shape*
T0*
Tshape0
�
=optimizer/gradients/optimizer/clip_by_value_1_grad/SelectV2_1SelectV2?optimizer/gradients/optimizer/clip_by_value_1_grad/GreaterEqual8optimizer/gradients/optimizer/clip_by_value_1_grad/zerosAoptimizer/gradients/optimizer/mul_2_grad/tuple/control_dependency*
T0
�
8optimizer/gradients/optimizer/clip_by_value_1_grad/Sum_1Sum=optimizer/gradients/optimizer/clip_by_value_1_grad/SelectV2_1Joptimizer/gradients/optimizer/clip_by_value_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
<optimizer/gradients/optimizer/clip_by_value_1_grad/Reshape_1Reshape8optimizer/gradients/optimizer/clip_by_value_1_grad/Sum_1:optimizer/gradients/optimizer/clip_by_value_1_grad/Shape_1*
T0*
Tshape0
�
Coptimizer/gradients/optimizer/clip_by_value_1_grad/tuple/group_depsNoOp;^optimizer/gradients/optimizer/clip_by_value_1_grad/Reshape=^optimizer/gradients/optimizer/clip_by_value_1_grad/Reshape_1
�
Koptimizer/gradients/optimizer/clip_by_value_1_grad/tuple/control_dependencyIdentity:optimizer/gradients/optimizer/clip_by_value_1_grad/ReshapeD^optimizer/gradients/optimizer/clip_by_value_1_grad/tuple/group_deps*
T0*M
_classC
A?loc:@optimizer/gradients/optimizer/clip_by_value_1_grad/Reshape
�
Moptimizer/gradients/optimizer/clip_by_value_1_grad/tuple/control_dependency_1Identity<optimizer/gradients/optimizer/clip_by_value_1_grad/Reshape_1D^optimizer/gradients/optimizer/clip_by_value_1_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients/optimizer/clip_by_value_1_grad/Reshape_1
o
0optimizer/gradients/optimizer/Maximum_grad/ShapeShapeoptimizer/SquaredDifference*
T0*
out_type0
s
2optimizer/gradients/optimizer/Maximum_grad/Shape_1Shapeoptimizer/SquaredDifference_1*
T0*
out_type0
�
2optimizer/gradients/optimizer/Maximum_grad/Shape_2Shape=optimizer/gradients/optimizer/DynamicPartition_grad/Reshape_1*
T0*
out_type0
c
6optimizer/gradients/optimizer/Maximum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
0optimizer/gradients/optimizer/Maximum_grad/zerosFill2optimizer/gradients/optimizer/Maximum_grad/Shape_26optimizer/gradients/optimizer/Maximum_grad/zeros/Const*
T0*

index_type0
�
7optimizer/gradients/optimizer/Maximum_grad/GreaterEqualGreaterEqualoptimizer/SquaredDifferenceoptimizer/SquaredDifference_1*
T0
�
@optimizer/gradients/optimizer/Maximum_grad/BroadcastGradientArgsBroadcastGradientArgs0optimizer/gradients/optimizer/Maximum_grad/Shape2optimizer/gradients/optimizer/Maximum_grad/Shape_1*
T0
�
3optimizer/gradients/optimizer/Maximum_grad/SelectV2SelectV27optimizer/gradients/optimizer/Maximum_grad/GreaterEqual=optimizer/gradients/optimizer/DynamicPartition_grad/Reshape_10optimizer/gradients/optimizer/Maximum_grad/zeros*
T0
�
.optimizer/gradients/optimizer/Maximum_grad/SumSum3optimizer/gradients/optimizer/Maximum_grad/SelectV2@optimizer/gradients/optimizer/Maximum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients/optimizer/Maximum_grad/ReshapeReshape.optimizer/gradients/optimizer/Maximum_grad/Sum0optimizer/gradients/optimizer/Maximum_grad/Shape*
T0*
Tshape0
�
5optimizer/gradients/optimizer/Maximum_grad/SelectV2_1SelectV27optimizer/gradients/optimizer/Maximum_grad/GreaterEqual0optimizer/gradients/optimizer/Maximum_grad/zeros=optimizer/gradients/optimizer/DynamicPartition_grad/Reshape_1*
T0
�
0optimizer/gradients/optimizer/Maximum_grad/Sum_1Sum5optimizer/gradients/optimizer/Maximum_grad/SelectV2_1Boptimizer/gradients/optimizer/Maximum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients/optimizer/Maximum_grad/Reshape_1Reshape0optimizer/gradients/optimizer/Maximum_grad/Sum_12optimizer/gradients/optimizer/Maximum_grad/Shape_1*
T0*
Tshape0
�
;optimizer/gradients/optimizer/Maximum_grad/tuple/group_depsNoOp3^optimizer/gradients/optimizer/Maximum_grad/Reshape5^optimizer/gradients/optimizer/Maximum_grad/Reshape_1
�
Coptimizer/gradients/optimizer/Maximum_grad/tuple/control_dependencyIdentity2optimizer/gradients/optimizer/Maximum_grad/Reshape<^optimizer/gradients/optimizer/Maximum_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients/optimizer/Maximum_grad/Reshape
�
Eoptimizer/gradients/optimizer/Maximum_grad/tuple/control_dependency_1Identity4optimizer/gradients/optimizer/Maximum_grad/Reshape_1<^optimizer/gradients/optimizer/Maximum_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients/optimizer/Maximum_grad/Reshape_1
d
 optimizer/gradients/zeros_like_3	ZerosLike,policy_1/softmax_cross_entropy_with_logits:1*
T0
�
Roptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/ExpandDims/dimConst*
dtype0*
valueB :
���������
�
Noptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/ExpandDims
ExpandDimsUoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits/Reshape_2_grad/ReshapeRoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/ExpandDims/dim*
T0*

Tdim0
�
Goptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/mulMulNoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/ExpandDims,policy_1/softmax_cross_entropy_with_logits:1*
T0
�
Noptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/LogSoftmax
LogSoftmax2policy_1/softmax_cross_entropy_with_logits/Reshape*
T0
�
Goptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/NegNegNoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/LogSoftmax*
T0
�
Toptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/ExpandDims_1/dimConst*
dtype0*
valueB :
���������
�
Poptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/ExpandDims_1
ExpandDimsUoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits/Reshape_2_grad/ReshapeToptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/ExpandDims_1/dim*
T0*

Tdim0
�
Ioptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/mul_1MulPoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/ExpandDims_1Goptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/Neg*
T0
�
Toptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/tuple/group_depsNoOpH^optimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/mulJ^optimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/mul_1
�
\optimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/tuple/control_dependencyIdentityGoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/mulU^optimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/tuple/group_deps*
T0*Z
_classP
NLloc:@optimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/mul
�
^optimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/tuple/control_dependency_1IdentityIoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/mul_1U^optimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/tuple/group_deps*
T0*\
_classR
PNloc:@optimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/mul_1
q
@optimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/ShapeShapeoptimizer/Exp*
T0*
out_type0
k
Boptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/Shape_1Const*
dtype0*
valueB 
�
Boptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/Shape_2ShapeKoptimizer/gradients/optimizer/clip_by_value_1_grad/tuple/control_dependency*
T0*
out_type0
s
Foptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
@optimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/zerosFillBoptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/Shape_2Foptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/zeros/Const*
T0*

index_type0
z
Doptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/LessEqual	LessEqualoptimizer/Expoptimizer/add_4*
T0
�
Poptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs@optimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/ShapeBoptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/Shape_1*
T0
�
Coptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/SelectV2SelectV2Doptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/LessEqualKoptimizer/gradients/optimizer/clip_by_value_1_grad/tuple/control_dependency@optimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/zeros*
T0
�
>optimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/SumSumCoptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/SelectV2Poptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Boptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/ReshapeReshape>optimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/Sum@optimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/Shape*
T0*
Tshape0
�
Eoptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/SelectV2_1SelectV2Doptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/LessEqual@optimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/zerosKoptimizer/gradients/optimizer/clip_by_value_1_grad/tuple/control_dependency*
T0
�
@optimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/Sum_1SumEoptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/SelectV2_1Roptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Doptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/Reshape_1Reshape@optimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/Sum_1Boptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/Shape_1*
T0*
Tshape0
�
Koptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/tuple/group_depsNoOpC^optimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/ReshapeE^optimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/Reshape_1
�
Soptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/tuple/control_dependencyIdentityBoptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/ReshapeL^optimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/tuple/group_deps*
T0*U
_classK
IGloc:@optimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/Reshape
�
Uoptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/tuple/control_dependency_1IdentityDoptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/Reshape_1L^optimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/tuple/group_deps*
T0*W
_classM
KIloc:@optimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/Reshape_1
�
;optimizer/gradients/optimizer/SquaredDifference_grad/scalarConstD^optimizer/gradients/optimizer/Maximum_grad/tuple/control_dependency*
dtype0*
valueB
 *   @
�
8optimizer/gradients/optimizer/SquaredDifference_grad/MulMul;optimizer/gradients/optimizer/SquaredDifference_grad/scalarCoptimizer/gradients/optimizer/Maximum_grad/tuple/control_dependency*
T0
�
8optimizer/gradients/optimizer/SquaredDifference_grad/subSuboptimizer/extrinsic_returnsoptimizer/Sum_3D^optimizer/gradients/optimizer/Maximum_grad/tuple/control_dependency*
T0
�
:optimizer/gradients/optimizer/SquaredDifference_grad/mul_1Mul8optimizer/gradients/optimizer/SquaredDifference_grad/Mul8optimizer/gradients/optimizer/SquaredDifference_grad/sub*
T0
y
:optimizer/gradients/optimizer/SquaredDifference_grad/ShapeShapeoptimizer/extrinsic_returns*
T0*
out_type0
o
<optimizer/gradients/optimizer/SquaredDifference_grad/Shape_1Shapeoptimizer/Sum_3*
T0*
out_type0
�
Joptimizer/gradients/optimizer/SquaredDifference_grad/BroadcastGradientArgsBroadcastGradientArgs:optimizer/gradients/optimizer/SquaredDifference_grad/Shape<optimizer/gradients/optimizer/SquaredDifference_grad/Shape_1*
T0
�
8optimizer/gradients/optimizer/SquaredDifference_grad/SumSum:optimizer/gradients/optimizer/SquaredDifference_grad/mul_1Joptimizer/gradients/optimizer/SquaredDifference_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
<optimizer/gradients/optimizer/SquaredDifference_grad/ReshapeReshape8optimizer/gradients/optimizer/SquaredDifference_grad/Sum:optimizer/gradients/optimizer/SquaredDifference_grad/Shape*
T0*
Tshape0
�
:optimizer/gradients/optimizer/SquaredDifference_grad/Sum_1Sum:optimizer/gradients/optimizer/SquaredDifference_grad/mul_1Loptimizer/gradients/optimizer/SquaredDifference_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
>optimizer/gradients/optimizer/SquaredDifference_grad/Reshape_1Reshape:optimizer/gradients/optimizer/SquaredDifference_grad/Sum_1<optimizer/gradients/optimizer/SquaredDifference_grad/Shape_1*
T0*
Tshape0
�
8optimizer/gradients/optimizer/SquaredDifference_grad/NegNeg>optimizer/gradients/optimizer/SquaredDifference_grad/Reshape_1*
T0
�
Eoptimizer/gradients/optimizer/SquaredDifference_grad/tuple/group_depsNoOp9^optimizer/gradients/optimizer/SquaredDifference_grad/Neg=^optimizer/gradients/optimizer/SquaredDifference_grad/Reshape
�
Moptimizer/gradients/optimizer/SquaredDifference_grad/tuple/control_dependencyIdentity<optimizer/gradients/optimizer/SquaredDifference_grad/ReshapeF^optimizer/gradients/optimizer/SquaredDifference_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients/optimizer/SquaredDifference_grad/Reshape
�
Ooptimizer/gradients/optimizer/SquaredDifference_grad/tuple/control_dependency_1Identity8optimizer/gradients/optimizer/SquaredDifference_grad/NegF^optimizer/gradients/optimizer/SquaredDifference_grad/tuple/group_deps*
T0*K
_classA
?=loc:@optimizer/gradients/optimizer/SquaredDifference_grad/Neg
�
=optimizer/gradients/optimizer/SquaredDifference_1_grad/scalarConstF^optimizer/gradients/optimizer/Maximum_grad/tuple/control_dependency_1*
dtype0*
valueB
 *   @
�
:optimizer/gradients/optimizer/SquaredDifference_1_grad/MulMul=optimizer/gradients/optimizer/SquaredDifference_1_grad/scalarEoptimizer/gradients/optimizer/Maximum_grad/tuple/control_dependency_1*
T0
�
:optimizer/gradients/optimizer/SquaredDifference_1_grad/subSuboptimizer/extrinsic_returnsoptimizer/add_3F^optimizer/gradients/optimizer/Maximum_grad/tuple/control_dependency_1*
T0
�
<optimizer/gradients/optimizer/SquaredDifference_1_grad/mul_1Mul:optimizer/gradients/optimizer/SquaredDifference_1_grad/Mul:optimizer/gradients/optimizer/SquaredDifference_1_grad/sub*
T0
{
<optimizer/gradients/optimizer/SquaredDifference_1_grad/ShapeShapeoptimizer/extrinsic_returns*
T0*
out_type0
q
>optimizer/gradients/optimizer/SquaredDifference_1_grad/Shape_1Shapeoptimizer/add_3*
T0*
out_type0
�
Loptimizer/gradients/optimizer/SquaredDifference_1_grad/BroadcastGradientArgsBroadcastGradientArgs<optimizer/gradients/optimizer/SquaredDifference_1_grad/Shape>optimizer/gradients/optimizer/SquaredDifference_1_grad/Shape_1*
T0
�
:optimizer/gradients/optimizer/SquaredDifference_1_grad/SumSum<optimizer/gradients/optimizer/SquaredDifference_1_grad/mul_1Loptimizer/gradients/optimizer/SquaredDifference_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
>optimizer/gradients/optimizer/SquaredDifference_1_grad/ReshapeReshape:optimizer/gradients/optimizer/SquaredDifference_1_grad/Sum<optimizer/gradients/optimizer/SquaredDifference_1_grad/Shape*
T0*
Tshape0
�
<optimizer/gradients/optimizer/SquaredDifference_1_grad/Sum_1Sum<optimizer/gradients/optimizer/SquaredDifference_1_grad/mul_1Noptimizer/gradients/optimizer/SquaredDifference_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
@optimizer/gradients/optimizer/SquaredDifference_1_grad/Reshape_1Reshape<optimizer/gradients/optimizer/SquaredDifference_1_grad/Sum_1>optimizer/gradients/optimizer/SquaredDifference_1_grad/Shape_1*
T0*
Tshape0
�
:optimizer/gradients/optimizer/SquaredDifference_1_grad/NegNeg@optimizer/gradients/optimizer/SquaredDifference_1_grad/Reshape_1*
T0
�
Goptimizer/gradients/optimizer/SquaredDifference_1_grad/tuple/group_depsNoOp;^optimizer/gradients/optimizer/SquaredDifference_1_grad/Neg?^optimizer/gradients/optimizer/SquaredDifference_1_grad/Reshape
�
Ooptimizer/gradients/optimizer/SquaredDifference_1_grad/tuple/control_dependencyIdentity>optimizer/gradients/optimizer/SquaredDifference_1_grad/ReshapeH^optimizer/gradients/optimizer/SquaredDifference_1_grad/tuple/group_deps*
T0*Q
_classG
ECloc:@optimizer/gradients/optimizer/SquaredDifference_1_grad/Reshape
�
Qoptimizer/gradients/optimizer/SquaredDifference_1_grad/tuple/control_dependency_1Identity:optimizer/gradients/optimizer/SquaredDifference_1_grad/NegH^optimizer/gradients/optimizer/SquaredDifference_1_grad/tuple/group_deps*
T0*M
_classC
A?loc:@optimizer/gradients/optimizer/SquaredDifference_1_grad/Neg
�
Qoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits/Reshape_grad/ShapeShapepolicy_1/strided_slice_3*
T0*
out_type0
�
Soptimizer/gradients/policy_1/softmax_cross_entropy_with_logits/Reshape_grad/ReshapeReshape\optimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/tuple/control_dependencyQoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits/Reshape_grad/Shape*
T0*
Tshape0
�
Soptimizer/gradients/policy_1/softmax_cross_entropy_with_logits/Reshape_1_grad/ShapeShapepolicy_1/Softmax_1*
T0*
out_type0
�
Uoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits/Reshape_1_grad/ReshapeReshape^optimizer/gradients/policy_1/softmax_cross_entropy_with_logits_grad/tuple/control_dependency_1Soptimizer/gradients/policy_1/softmax_cross_entropy_with_logits/Reshape_1_grad/Shape*
T0*
Tshape0
�
optimizer/gradients/AddNAddNAoptimizer/gradients/optimizer/mul_1_grad/tuple/control_dependencySoptimizer/gradients/optimizer/clip_by_value_1/Minimum_grad/tuple/control_dependency*
N*
T0*C
_class9
75loc:@optimizer/gradients/optimizer/mul_1_grad/Reshape
c
*optimizer/gradients/optimizer/Exp_grad/mulMuloptimizer/gradients/AddNoptimizer/Exp*
T0
s
.optimizer/gradients/optimizer/Sum_3_grad/ShapeShape!optimizer/extrinsic_value/BiasAdd*
T0*
out_type0
�
-optimizer/gradients/optimizer/Sum_3_grad/SizeConst*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_3_grad/Shape*
dtype0*
value	B :
�
,optimizer/gradients/optimizer/Sum_3_grad/addAddV2!optimizer/Sum_3/reduction_indices-optimizer/gradients/optimizer/Sum_3_grad/Size*
T0*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_3_grad/Shape
�
,optimizer/gradients/optimizer/Sum_3_grad/modFloorMod,optimizer/gradients/optimizer/Sum_3_grad/add-optimizer/gradients/optimizer/Sum_3_grad/Size*
T0*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_3_grad/Shape
�
0optimizer/gradients/optimizer/Sum_3_grad/Shape_1Const*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_3_grad/Shape*
dtype0*
valueB 
�
4optimizer/gradients/optimizer/Sum_3_grad/range/startConst*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_3_grad/Shape*
dtype0*
value	B : 
�
4optimizer/gradients/optimizer/Sum_3_grad/range/deltaConst*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_3_grad/Shape*
dtype0*
value	B :
�
.optimizer/gradients/optimizer/Sum_3_grad/rangeRange4optimizer/gradients/optimizer/Sum_3_grad/range/start-optimizer/gradients/optimizer/Sum_3_grad/Size4optimizer/gradients/optimizer/Sum_3_grad/range/delta*

Tidx0*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_3_grad/Shape
�
3optimizer/gradients/optimizer/Sum_3_grad/Fill/valueConst*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_3_grad/Shape*
dtype0*
value	B :
�
-optimizer/gradients/optimizer/Sum_3_grad/FillFill0optimizer/gradients/optimizer/Sum_3_grad/Shape_13optimizer/gradients/optimizer/Sum_3_grad/Fill/value*
T0*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_3_grad/Shape*

index_type0
�
6optimizer/gradients/optimizer/Sum_3_grad/DynamicStitchDynamicStitch.optimizer/gradients/optimizer/Sum_3_grad/range,optimizer/gradients/optimizer/Sum_3_grad/mod.optimizer/gradients/optimizer/Sum_3_grad/Shape-optimizer/gradients/optimizer/Sum_3_grad/Fill*
N*
T0*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_3_grad/Shape
�
0optimizer/gradients/optimizer/Sum_3_grad/ReshapeReshapeOoptimizer/gradients/optimizer/SquaredDifference_grad/tuple/control_dependency_16optimizer/gradients/optimizer/Sum_3_grad/DynamicStitch*
T0*
Tshape0
�
4optimizer/gradients/optimizer/Sum_3_grad/BroadcastToBroadcastTo0optimizer/gradients/optimizer/Sum_3_grad/Reshape.optimizer/gradients/optimizer/Sum_3_grad/Shape*
T0*

Tidx0
t
.optimizer/gradients/optimizer/add_3_grad/ShapeShape"optimizer/extrinsic_value_estimate*
T0*
out_type0
k
0optimizer/gradients/optimizer/add_3_grad/Shape_1Shapeoptimizer/clip_by_value*
T0*
out_type0
�
>optimizer/gradients/optimizer/add_3_grad/BroadcastGradientArgsBroadcastGradientArgs.optimizer/gradients/optimizer/add_3_grad/Shape0optimizer/gradients/optimizer/add_3_grad/Shape_1*
T0
�
,optimizer/gradients/optimizer/add_3_grad/SumSumQoptimizer/gradients/optimizer/SquaredDifference_1_grad/tuple/control_dependency_1>optimizer/gradients/optimizer/add_3_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
0optimizer/gradients/optimizer/add_3_grad/ReshapeReshape,optimizer/gradients/optimizer/add_3_grad/Sum.optimizer/gradients/optimizer/add_3_grad/Shape*
T0*
Tshape0
�
.optimizer/gradients/optimizer/add_3_grad/Sum_1SumQoptimizer/gradients/optimizer/SquaredDifference_1_grad/tuple/control_dependency_1@optimizer/gradients/optimizer/add_3_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients/optimizer/add_3_grad/Reshape_1Reshape.optimizer/gradients/optimizer/add_3_grad/Sum_10optimizer/gradients/optimizer/add_3_grad/Shape_1*
T0*
Tshape0
�
9optimizer/gradients/optimizer/add_3_grad/tuple/group_depsNoOp1^optimizer/gradients/optimizer/add_3_grad/Reshape3^optimizer/gradients/optimizer/add_3_grad/Reshape_1
�
Aoptimizer/gradients/optimizer/add_3_grad/tuple/control_dependencyIdentity0optimizer/gradients/optimizer/add_3_grad/Reshape:^optimizer/gradients/optimizer/add_3_grad/tuple/group_deps*
T0*C
_class9
75loc:@optimizer/gradients/optimizer/add_3_grad/Reshape
�
Coptimizer/gradients/optimizer/add_3_grad/tuple/control_dependency_1Identity2optimizer/gradients/optimizer/add_3_grad/Reshape_1:^optimizer/gradients/optimizer/add_3_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients/optimizer/add_3_grad/Reshape_1
s
7optimizer/gradients/policy_1/strided_slice_3_grad/ShapeShapepolicy_1/concat_2/concat*
T0*
out_type0
}
Hoptimizer/gradients/policy_1/strided_slice_3_grad/StridedSliceGrad/beginConst*
dtype0*
valueB"        
{
Foptimizer/gradients/policy_1/strided_slice_3_grad/StridedSliceGrad/endConst*
dtype0*
valueB"       

Joptimizer/gradients/policy_1/strided_slice_3_grad/StridedSliceGrad/stridesConst*
dtype0*
valueB"      
�
Boptimizer/gradients/policy_1/strided_slice_3_grad/StridedSliceGradStridedSliceGrad7optimizer/gradients/policy_1/strided_slice_3_grad/ShapeHoptimizer/gradients/policy_1/strided_slice_3_grad/StridedSliceGrad/beginFoptimizer/gradients/policy_1/strided_slice_3_grad/StridedSliceGrad/endJoptimizer/gradients/policy_1/strided_slice_3_grad/StridedSliceGrad/stridesSoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits/Reshape_grad/Reshape*
Index0*
T0*

begin_mask*
ellipsis_mask *
end_mask*
new_axis_mask *
shrink_axis_mask 
�
/optimizer/gradients/policy_1/Softmax_1_grad/mulMulUoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits/Reshape_1_grad/Reshapepolicy_1/Softmax_1*
T0
t
Aoptimizer/gradients/policy_1/Softmax_1_grad/Sum/reduction_indicesConst*
dtype0*
valueB :
���������
�
/optimizer/gradients/policy_1/Softmax_1_grad/SumSum/optimizer/gradients/policy_1/Softmax_1_grad/mulAoptimizer/gradients/policy_1/Softmax_1_grad/Sum/reduction_indices*
T0*

Tidx0*
	keep_dims(
�
/optimizer/gradients/policy_1/Softmax_1_grad/subSubUoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits/Reshape_1_grad/Reshape/optimizer/gradients/policy_1/Softmax_1_grad/Sum*
T0
�
1optimizer/gradients/policy_1/Softmax_1_grad/mul_1Mul/optimizer/gradients/policy_1/Softmax_1_grad/subpolicy_1/Softmax_1*
T0
`
.optimizer/gradients/optimizer/sub_1_grad/ShapeShapepolicy_1/Sum_2*
T0*
out_type0
c
0optimizer/gradients/optimizer/sub_1_grad/Shape_1Shapeoptimizer/Sum_1*
T0*
out_type0
�
>optimizer/gradients/optimizer/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgs.optimizer/gradients/optimizer/sub_1_grad/Shape0optimizer/gradients/optimizer/sub_1_grad/Shape_1*
T0
�
,optimizer/gradients/optimizer/sub_1_grad/SumSum*optimizer/gradients/optimizer/Exp_grad/mul>optimizer/gradients/optimizer/sub_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
0optimizer/gradients/optimizer/sub_1_grad/ReshapeReshape,optimizer/gradients/optimizer/sub_1_grad/Sum.optimizer/gradients/optimizer/sub_1_grad/Shape*
T0*
Tshape0
h
,optimizer/gradients/optimizer/sub_1_grad/NegNeg*optimizer/gradients/optimizer/Exp_grad/mul*
T0
�
.optimizer/gradients/optimizer/sub_1_grad/Sum_1Sum,optimizer/gradients/optimizer/sub_1_grad/Neg@optimizer/gradients/optimizer/sub_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients/optimizer/sub_1_grad/Reshape_1Reshape.optimizer/gradients/optimizer/sub_1_grad/Sum_10optimizer/gradients/optimizer/sub_1_grad/Shape_1*
T0*
Tshape0
�
9optimizer/gradients/optimizer/sub_1_grad/tuple/group_depsNoOp1^optimizer/gradients/optimizer/sub_1_grad/Reshape3^optimizer/gradients/optimizer/sub_1_grad/Reshape_1
�
Aoptimizer/gradients/optimizer/sub_1_grad/tuple/control_dependencyIdentity0optimizer/gradients/optimizer/sub_1_grad/Reshape:^optimizer/gradients/optimizer/sub_1_grad/tuple/group_deps*
T0*C
_class9
75loc:@optimizer/gradients/optimizer/sub_1_grad/Reshape
�
Coptimizer/gradients/optimizer/sub_1_grad/tuple/control_dependency_1Identity2optimizer/gradients/optimizer/sub_1_grad/Reshape_1:^optimizer/gradients/optimizer/sub_1_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients/optimizer/sub_1_grad/Reshape_1
y
6optimizer/gradients/optimizer/clip_by_value_grad/ShapeShapeoptimizer/clip_by_value/Minimum*
T0*
out_type0
a
8optimizer/gradients/optimizer/clip_by_value_grad/Shape_1Const*
dtype0*
valueB 
�
8optimizer/gradients/optimizer/clip_by_value_grad/Shape_2ShapeCoptimizer/gradients/optimizer/add_3_grad/tuple/control_dependency_1*
T0*
out_type0
i
<optimizer/gradients/optimizer/clip_by_value_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
6optimizer/gradients/optimizer/clip_by_value_grad/zerosFill8optimizer/gradients/optimizer/clip_by_value_grad/Shape_2<optimizer/gradients/optimizer/clip_by_value_grad/zeros/Const*
T0*

index_type0
�
=optimizer/gradients/optimizer/clip_by_value_grad/GreaterEqualGreaterEqualoptimizer/clip_by_value/Minimumoptimizer/Neg_1*
T0
�
Foptimizer/gradients/optimizer/clip_by_value_grad/BroadcastGradientArgsBroadcastGradientArgs6optimizer/gradients/optimizer/clip_by_value_grad/Shape8optimizer/gradients/optimizer/clip_by_value_grad/Shape_1*
T0
�
9optimizer/gradients/optimizer/clip_by_value_grad/SelectV2SelectV2=optimizer/gradients/optimizer/clip_by_value_grad/GreaterEqualCoptimizer/gradients/optimizer/add_3_grad/tuple/control_dependency_16optimizer/gradients/optimizer/clip_by_value_grad/zeros*
T0
�
4optimizer/gradients/optimizer/clip_by_value_grad/SumSum9optimizer/gradients/optimizer/clip_by_value_grad/SelectV2Foptimizer/gradients/optimizer/clip_by_value_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
8optimizer/gradients/optimizer/clip_by_value_grad/ReshapeReshape4optimizer/gradients/optimizer/clip_by_value_grad/Sum6optimizer/gradients/optimizer/clip_by_value_grad/Shape*
T0*
Tshape0
�
;optimizer/gradients/optimizer/clip_by_value_grad/SelectV2_1SelectV2=optimizer/gradients/optimizer/clip_by_value_grad/GreaterEqual6optimizer/gradients/optimizer/clip_by_value_grad/zerosCoptimizer/gradients/optimizer/add_3_grad/tuple/control_dependency_1*
T0
�
6optimizer/gradients/optimizer/clip_by_value_grad/Sum_1Sum;optimizer/gradients/optimizer/clip_by_value_grad/SelectV2_1Hoptimizer/gradients/optimizer/clip_by_value_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
:optimizer/gradients/optimizer/clip_by_value_grad/Reshape_1Reshape6optimizer/gradients/optimizer/clip_by_value_grad/Sum_18optimizer/gradients/optimizer/clip_by_value_grad/Shape_1*
T0*
Tshape0
�
Aoptimizer/gradients/optimizer/clip_by_value_grad/tuple/group_depsNoOp9^optimizer/gradients/optimizer/clip_by_value_grad/Reshape;^optimizer/gradients/optimizer/clip_by_value_grad/Reshape_1
�
Ioptimizer/gradients/optimizer/clip_by_value_grad/tuple/control_dependencyIdentity8optimizer/gradients/optimizer/clip_by_value_grad/ReshapeB^optimizer/gradients/optimizer/clip_by_value_grad/tuple/group_deps*
T0*K
_classA
?=loc:@optimizer/gradients/optimizer/clip_by_value_grad/Reshape
�
Koptimizer/gradients/optimizer/clip_by_value_grad/tuple/control_dependency_1Identity:optimizer/gradients/optimizer/clip_by_value_grad/Reshape_1B^optimizer/gradients/optimizer/clip_by_value_grad/tuple/group_deps*
T0*M
_classC
A?loc:@optimizer/gradients/optimizer/clip_by_value_grad/Reshape_1
s
7optimizer/gradients/policy_1/strided_slice_2_grad/ShapeShapepolicy_1/concat_2/concat*
T0*
out_type0
}
Hoptimizer/gradients/policy_1/strided_slice_2_grad/StridedSliceGrad/beginConst*
dtype0*
valueB"        
{
Foptimizer/gradients/policy_1/strided_slice_2_grad/StridedSliceGrad/endConst*
dtype0*
valueB"       

Joptimizer/gradients/policy_1/strided_slice_2_grad/StridedSliceGrad/stridesConst*
dtype0*
valueB"      
�
Boptimizer/gradients/policy_1/strided_slice_2_grad/StridedSliceGradStridedSliceGrad7optimizer/gradients/policy_1/strided_slice_2_grad/ShapeHoptimizer/gradients/policy_1/strided_slice_2_grad/StridedSliceGrad/beginFoptimizer/gradients/policy_1/strided_slice_2_grad/StridedSliceGrad/endJoptimizer/gradients/policy_1/strided_slice_2_grad/StridedSliceGrad/strides1optimizer/gradients/policy_1/Softmax_1_grad/mul_1*
Index0*
T0*

begin_mask*
ellipsis_mask *
end_mask*
new_axis_mask *
shrink_axis_mask 
a
-optimizer/gradients/policy_1/Sum_2_grad/ShapeShapepolicy_1/stack_1*
T0*
out_type0
�
3optimizer/gradients/policy_1/Sum_2_grad/BroadcastToBroadcastToAoptimizer/gradients/optimizer/sub_1_grad/tuple/control_dependency-optimizer/gradients/policy_1/Sum_2_grad/Shape*
T0*

Tidx0
o
>optimizer/gradients/optimizer/clip_by_value/Minimum_grad/ShapeShapeoptimizer/sub*
T0*
out_type0
i
@optimizer/gradients/optimizer/clip_by_value/Minimum_grad/Shape_1Const*
dtype0*
valueB 
�
@optimizer/gradients/optimizer/clip_by_value/Minimum_grad/Shape_2ShapeIoptimizer/gradients/optimizer/clip_by_value_grad/tuple/control_dependency*
T0*
out_type0
q
Doptimizer/gradients/optimizer/clip_by_value/Minimum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
>optimizer/gradients/optimizer/clip_by_value/Minimum_grad/zerosFill@optimizer/gradients/optimizer/clip_by_value/Minimum_grad/Shape_2Doptimizer/gradients/optimizer/clip_by_value/Minimum_grad/zeros/Const*
T0*

index_type0
�
Boptimizer/gradients/optimizer/clip_by_value/Minimum_grad/LessEqual	LessEqualoptimizer/suboptimizer/PolynomialDecay_1*
T0
�
Noptimizer/gradients/optimizer/clip_by_value/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs>optimizer/gradients/optimizer/clip_by_value/Minimum_grad/Shape@optimizer/gradients/optimizer/clip_by_value/Minimum_grad/Shape_1*
T0
�
Aoptimizer/gradients/optimizer/clip_by_value/Minimum_grad/SelectV2SelectV2Boptimizer/gradients/optimizer/clip_by_value/Minimum_grad/LessEqualIoptimizer/gradients/optimizer/clip_by_value_grad/tuple/control_dependency>optimizer/gradients/optimizer/clip_by_value/Minimum_grad/zeros*
T0
�
<optimizer/gradients/optimizer/clip_by_value/Minimum_grad/SumSumAoptimizer/gradients/optimizer/clip_by_value/Minimum_grad/SelectV2Noptimizer/gradients/optimizer/clip_by_value/Minimum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
@optimizer/gradients/optimizer/clip_by_value/Minimum_grad/ReshapeReshape<optimizer/gradients/optimizer/clip_by_value/Minimum_grad/Sum>optimizer/gradients/optimizer/clip_by_value/Minimum_grad/Shape*
T0*
Tshape0
�
Coptimizer/gradients/optimizer/clip_by_value/Minimum_grad/SelectV2_1SelectV2Boptimizer/gradients/optimizer/clip_by_value/Minimum_grad/LessEqual>optimizer/gradients/optimizer/clip_by_value/Minimum_grad/zerosIoptimizer/gradients/optimizer/clip_by_value_grad/tuple/control_dependency*
T0
�
>optimizer/gradients/optimizer/clip_by_value/Minimum_grad/Sum_1SumCoptimizer/gradients/optimizer/clip_by_value/Minimum_grad/SelectV2_1Poptimizer/gradients/optimizer/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Boptimizer/gradients/optimizer/clip_by_value/Minimum_grad/Reshape_1Reshape>optimizer/gradients/optimizer/clip_by_value/Minimum_grad/Sum_1@optimizer/gradients/optimizer/clip_by_value/Minimum_grad/Shape_1*
T0*
Tshape0
�
Ioptimizer/gradients/optimizer/clip_by_value/Minimum_grad/tuple/group_depsNoOpA^optimizer/gradients/optimizer/clip_by_value/Minimum_grad/ReshapeC^optimizer/gradients/optimizer/clip_by_value/Minimum_grad/Reshape_1
�
Qoptimizer/gradients/optimizer/clip_by_value/Minimum_grad/tuple/control_dependencyIdentity@optimizer/gradients/optimizer/clip_by_value/Minimum_grad/ReshapeJ^optimizer/gradients/optimizer/clip_by_value/Minimum_grad/tuple/group_deps*
T0*S
_classI
GEloc:@optimizer/gradients/optimizer/clip_by_value/Minimum_grad/Reshape
�
Soptimizer/gradients/optimizer/clip_by_value/Minimum_grad/tuple/control_dependency_1IdentityBoptimizer/gradients/optimizer/clip_by_value/Minimum_grad/Reshape_1J^optimizer/gradients/optimizer/clip_by_value/Minimum_grad/tuple/group_deps*
T0*U
_classK
IGloc:@optimizer/gradients/optimizer/clip_by_value/Minimum_grad/Reshape_1
�
1optimizer/gradients/policy_1/stack_1_grad/unstackUnpack3optimizer/gradients/policy_1/Sum_2_grad/BroadcastTo*
T0*

axis*	
num
_
,optimizer/gradients/optimizer/sub_grad/ShapeShapeoptimizer/Sum_2*
T0*
out_type0
t
.optimizer/gradients/optimizer/sub_grad/Shape_1Shape"optimizer/extrinsic_value_estimate*
T0*
out_type0
�
<optimizer/gradients/optimizer/sub_grad/BroadcastGradientArgsBroadcastGradientArgs,optimizer/gradients/optimizer/sub_grad/Shape.optimizer/gradients/optimizer/sub_grad/Shape_1*
T0
�
*optimizer/gradients/optimizer/sub_grad/SumSumQoptimizer/gradients/optimizer/clip_by_value/Minimum_grad/tuple/control_dependency<optimizer/gradients/optimizer/sub_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
.optimizer/gradients/optimizer/sub_grad/ReshapeReshape*optimizer/gradients/optimizer/sub_grad/Sum,optimizer/gradients/optimizer/sub_grad/Shape*
T0*
Tshape0
�
*optimizer/gradients/optimizer/sub_grad/NegNegQoptimizer/gradients/optimizer/clip_by_value/Minimum_grad/tuple/control_dependency*
T0
�
,optimizer/gradients/optimizer/sub_grad/Sum_1Sum*optimizer/gradients/optimizer/sub_grad/Neg>optimizer/gradients/optimizer/sub_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
0optimizer/gradients/optimizer/sub_grad/Reshape_1Reshape,optimizer/gradients/optimizer/sub_grad/Sum_1.optimizer/gradients/optimizer/sub_grad/Shape_1*
T0*
Tshape0
�
7optimizer/gradients/optimizer/sub_grad/tuple/group_depsNoOp/^optimizer/gradients/optimizer/sub_grad/Reshape1^optimizer/gradients/optimizer/sub_grad/Reshape_1
�
?optimizer/gradients/optimizer/sub_grad/tuple/control_dependencyIdentity.optimizer/gradients/optimizer/sub_grad/Reshape8^optimizer/gradients/optimizer/sub_grad/tuple/group_deps*
T0*A
_class7
53loc:@optimizer/gradients/optimizer/sub_grad/Reshape
�
Aoptimizer/gradients/optimizer/sub_grad/tuple/control_dependency_1Identity0optimizer/gradients/optimizer/sub_grad/Reshape_18^optimizer/gradients/optimizer/sub_grad/tuple/group_deps*
T0*C
_class9
75loc:@optimizer/gradients/optimizer/sub_grad/Reshape_1
l
)optimizer/gradients/policy_1/Neg_grad/NegNeg1optimizer/gradients/policy_1/stack_1_grad/unstack*
T0
s
.optimizer/gradients/optimizer/Sum_2_grad/ShapeShape!optimizer/extrinsic_value/BiasAdd*
T0*
out_type0
�
-optimizer/gradients/optimizer/Sum_2_grad/SizeConst*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_2_grad/Shape*
dtype0*
value	B :
�
,optimizer/gradients/optimizer/Sum_2_grad/addAddV2!optimizer/Sum_2/reduction_indices-optimizer/gradients/optimizer/Sum_2_grad/Size*
T0*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_2_grad/Shape
�
,optimizer/gradients/optimizer/Sum_2_grad/modFloorMod,optimizer/gradients/optimizer/Sum_2_grad/add-optimizer/gradients/optimizer/Sum_2_grad/Size*
T0*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_2_grad/Shape
�
0optimizer/gradients/optimizer/Sum_2_grad/Shape_1Const*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_2_grad/Shape*
dtype0*
valueB 
�
4optimizer/gradients/optimizer/Sum_2_grad/range/startConst*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_2_grad/Shape*
dtype0*
value	B : 
�
4optimizer/gradients/optimizer/Sum_2_grad/range/deltaConst*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_2_grad/Shape*
dtype0*
value	B :
�
.optimizer/gradients/optimizer/Sum_2_grad/rangeRange4optimizer/gradients/optimizer/Sum_2_grad/range/start-optimizer/gradients/optimizer/Sum_2_grad/Size4optimizer/gradients/optimizer/Sum_2_grad/range/delta*

Tidx0*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_2_grad/Shape
�
3optimizer/gradients/optimizer/Sum_2_grad/Fill/valueConst*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_2_grad/Shape*
dtype0*
value	B :
�
-optimizer/gradients/optimizer/Sum_2_grad/FillFill0optimizer/gradients/optimizer/Sum_2_grad/Shape_13optimizer/gradients/optimizer/Sum_2_grad/Fill/value*
T0*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_2_grad/Shape*

index_type0
�
6optimizer/gradients/optimizer/Sum_2_grad/DynamicStitchDynamicStitch.optimizer/gradients/optimizer/Sum_2_grad/range,optimizer/gradients/optimizer/Sum_2_grad/mod.optimizer/gradients/optimizer/Sum_2_grad/Shape-optimizer/gradients/optimizer/Sum_2_grad/Fill*
N*
T0*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_2_grad/Shape
�
0optimizer/gradients/optimizer/Sum_2_grad/ReshapeReshape?optimizer/gradients/optimizer/sub_grad/tuple/control_dependency6optimizer/gradients/optimizer/Sum_2_grad/DynamicStitch*
T0*
Tshape0
�
4optimizer/gradients/optimizer/Sum_2_grad/BroadcastToBroadcastTo0optimizer/gradients/optimizer/Sum_2_grad/Reshape.optimizer/gradients/optimizer/Sum_2_grad/Shape*
T0*

Tidx0
�
Uoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1/Reshape_2_grad/ShapeShape,policy_1/softmax_cross_entropy_with_logits_1*
T0*
out_type0
�
Woptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1/Reshape_2_grad/ReshapeReshape)optimizer/gradients/policy_1/Neg_grad/NegUoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1/Reshape_2_grad/Shape*
T0*
Tshape0
�
optimizer/gradients/AddN_1AddN4optimizer/gradients/optimizer/Sum_3_grad/BroadcastTo4optimizer/gradients/optimizer/Sum_2_grad/BroadcastTo*
N*
T0*G
_class=
;9loc:@optimizer/gradients/optimizer/Sum_3_grad/BroadcastTo
�
Foptimizer/gradients/optimizer/extrinsic_value/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients/AddN_1*
T0*
data_formatNHWC
�
Koptimizer/gradients/optimizer/extrinsic_value/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients/AddN_1G^optimizer/gradients/optimizer/extrinsic_value/BiasAdd_grad/BiasAddGrad
�
Soptimizer/gradients/optimizer/extrinsic_value/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients/AddN_1L^optimizer/gradients/optimizer/extrinsic_value/BiasAdd_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients/optimizer/Sum_3_grad/BroadcastTo
�
Uoptimizer/gradients/optimizer/extrinsic_value/BiasAdd_grad/tuple/control_dependency_1IdentityFoptimizer/gradients/optimizer/extrinsic_value/BiasAdd_grad/BiasAddGradL^optimizer/gradients/optimizer/extrinsic_value/BiasAdd_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients/optimizer/extrinsic_value/BiasAdd_grad/BiasAddGrad
f
 optimizer/gradients/zeros_like_4	ZerosLike.policy_1/softmax_cross_entropy_with_logits_1:1*
T0
�
Toptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/ExpandDims/dimConst*
dtype0*
valueB :
���������
�
Poptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/ExpandDims
ExpandDimsWoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1/Reshape_2_grad/ReshapeToptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/ExpandDims/dim*
T0*

Tdim0
�
Ioptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/mulMulPoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/ExpandDims.policy_1/softmax_cross_entropy_with_logits_1:1*
T0
�
Poptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/LogSoftmax
LogSoftmax4policy_1/softmax_cross_entropy_with_logits_1/Reshape*
T0
�
Ioptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/NegNegPoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/LogSoftmax*
T0
�
Voptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/ExpandDims_1/dimConst*
dtype0*
valueB :
���������
�
Roptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/ExpandDims_1
ExpandDimsWoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1/Reshape_2_grad/ReshapeVoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/ExpandDims_1/dim*
T0*

Tdim0
�
Koptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/mul_1MulRoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/ExpandDims_1Ioptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/Neg*
T0
�
Voptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/tuple/group_depsNoOpJ^optimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/mulL^optimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/mul_1
�
^optimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/tuple/control_dependencyIdentityIoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/mulW^optimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/tuple/group_deps*
T0*\
_classR
PNloc:@optimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/mul
�
`optimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/tuple/control_dependency_1IdentityKoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/mul_1W^optimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/tuple/group_deps*
T0*^
_classT
RPloc:@optimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/mul_1
�
@optimizer/gradients/optimizer/extrinsic_value/MatMul_grad/MatMulMatMulSoptimizer/gradients/optimizer/extrinsic_value/BiasAdd_grad/tuple/control_dependency&optimizer//extrinsic_value/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Boptimizer/gradients/optimizer/extrinsic_value/MatMul_grad/MatMul_1MatMul#optimizer/main_graph_0/hidden_1/MulSoptimizer/gradients/optimizer/extrinsic_value/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Joptimizer/gradients/optimizer/extrinsic_value/MatMul_grad/tuple/group_depsNoOpA^optimizer/gradients/optimizer/extrinsic_value/MatMul_grad/MatMulC^optimizer/gradients/optimizer/extrinsic_value/MatMul_grad/MatMul_1
�
Roptimizer/gradients/optimizer/extrinsic_value/MatMul_grad/tuple/control_dependencyIdentity@optimizer/gradients/optimizer/extrinsic_value/MatMul_grad/MatMulK^optimizer/gradients/optimizer/extrinsic_value/MatMul_grad/tuple/group_deps*
T0*S
_classI
GEloc:@optimizer/gradients/optimizer/extrinsic_value/MatMul_grad/MatMul
�
Toptimizer/gradients/optimizer/extrinsic_value/MatMul_grad/tuple/control_dependency_1IdentityBoptimizer/gradients/optimizer/extrinsic_value/MatMul_grad/MatMul_1K^optimizer/gradients/optimizer/extrinsic_value/MatMul_grad/tuple/group_deps*
T0*U
_classK
IGloc:@optimizer/gradients/optimizer/extrinsic_value/MatMul_grad/MatMul_1
�
Soptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1/Reshape_grad/ShapeShapepolicy_1/strided_slice_5*
T0*
out_type0
�
Uoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1/Reshape_grad/ReshapeReshape^optimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1_grad/tuple/control_dependencySoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1/Reshape_grad/Shape*
T0*
Tshape0
�
Boptimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/ShapeShape'optimizer/main_graph_0/hidden_1/BiasAdd*
T0*
out_type0
�
Doptimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/Shape_1Shape'optimizer/main_graph_0/hidden_1/Sigmoid*
T0*
out_type0
�
Roptimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsBoptimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/ShapeDoptimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/Shape_1*
T0
�
@optimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/MulMulRoptimizer/gradients/optimizer/extrinsic_value/MatMul_grad/tuple/control_dependency'optimizer/main_graph_0/hidden_1/Sigmoid*
T0
�
@optimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/SumSum@optimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/MulRoptimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Doptimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/ReshapeReshape@optimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/SumBoptimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/Shape*
T0*
Tshape0
�
Boptimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/Mul_1Mul'optimizer/main_graph_0/hidden_1/BiasAddRoptimizer/gradients/optimizer/extrinsic_value/MatMul_grad/tuple/control_dependency*
T0
�
Boptimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/Sum_1SumBoptimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/Mul_1Toptimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Foptimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape_1ReshapeBoptimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/Sum_1Doptimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/Shape_1*
T0*
Tshape0
�
Moptimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/group_depsNoOpE^optimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/ReshapeG^optimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape_1
�
Uoptimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/control_dependencyIdentityDoptimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/ReshapeN^optimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/group_deps*
T0*W
_classM
KIloc:@optimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape
�
Woptimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency_1IdentityFoptimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape_1N^optimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape_1
s
7optimizer/gradients/policy_1/strided_slice_5_grad/ShapeShapepolicy_1/concat_2/concat*
T0*
out_type0
}
Hoptimizer/gradients/policy_1/strided_slice_5_grad/StridedSliceGrad/beginConst*
dtype0*
valueB"        
{
Foptimizer/gradients/policy_1/strided_slice_5_grad/StridedSliceGrad/endConst*
dtype0*
valueB"       

Joptimizer/gradients/policy_1/strided_slice_5_grad/StridedSliceGrad/stridesConst*
dtype0*
valueB"      
�
Boptimizer/gradients/policy_1/strided_slice_5_grad/StridedSliceGradStridedSliceGrad7optimizer/gradients/policy_1/strided_slice_5_grad/ShapeHoptimizer/gradients/policy_1/strided_slice_5_grad/StridedSliceGrad/beginFoptimizer/gradients/policy_1/strided_slice_5_grad/StridedSliceGrad/endJoptimizer/gradients/policy_1/strided_slice_5_grad/StridedSliceGrad/stridesUoptimizer/gradients/policy_1/softmax_cross_entropy_with_logits_1/Reshape_grad/Reshape*
Index0*
T0*

begin_mask*
ellipsis_mask *
end_mask*
new_axis_mask *
shrink_axis_mask 
�
Loptimizer/gradients/optimizer/main_graph_0/hidden_1/Sigmoid_grad/SigmoidGradSigmoidGrad'optimizer/main_graph_0/hidden_1/SigmoidWoptimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency_1*
T0
�
optimizer/gradients/AddN_2AddNBoptimizer/gradients/policy_1/strided_slice_3_grad/StridedSliceGradBoptimizer/gradients/policy_1/strided_slice_2_grad/StridedSliceGradBoptimizer/gradients/policy_1/strided_slice_5_grad/StridedSliceGrad*
N*
T0*U
_classK
IGloc:@optimizer/gradients/policy_1/strided_slice_3_grad/StridedSliceGrad
�
optimizer/gradients/AddN_3AddNUoptimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/control_dependencyLoptimizer/gradients/optimizer/main_graph_0/hidden_1/Sigmoid_grad/SigmoidGrad*
N*
T0*W
_classM
KIloc:@optimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape
�
Loptimizer/gradients/optimizer/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients/AddN_3*
T0*
data_formatNHWC
�
Qoptimizer/gradients/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients/AddN_3M^optimizer/gradients/optimizer/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad
�
Yoptimizer/gradients/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients/AddN_3R^optimizer/gradients/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*W
_classM
KIloc:@optimizer/gradients/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape
�
[optimizer/gradients/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency_1IdentityLoptimizer/gradients/optimizer/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGradR^optimizer/gradients/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*_
_classU
SQloc:@optimizer/gradients/optimizer/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad
v
2optimizer/gradients/policy_1/Log_1_grad/Reciprocal
Reciprocalpolicy_1/add_2^optimizer/gradients/AddN_2*
T0
�
+optimizer/gradients/policy_1/Log_1_grad/mulMuloptimizer/gradients/AddN_22optimizer/gradients/policy_1/Log_1_grad/Reciprocal*
T0
�
Foptimizer/gradients/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMulMatMulYoptimizer/gradients/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency,optimizer//main_graph_0/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Hoptimizer/gradients/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMul_1MatMul#optimizer/main_graph_0/hidden_0/MulYoptimizer/gradients/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Poptimizer/gradients/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/group_depsNoOpG^optimizer/gradients/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMulI^optimizer/gradients/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMul_1
�
Xoptimizer/gradients/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependencyIdentityFoptimizer/gradients/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMulQ^optimizer/gradients/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMul
�
Zoptimizer/gradients/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency_1IdentityHoptimizer/gradients/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMul_1Q^optimizer/gradients/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/group_deps*
T0*[
_classQ
OMloc:@optimizer/gradients/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMul_1
a
-optimizer/gradients/policy_1/add_2_grad/ShapeShapepolicy_1/truediv*
T0*
out_type0
c
/optimizer/gradients/policy_1/add_2_grad/Shape_1Shapepolicy_1/add_2/y*
T0*
out_type0
�
=optimizer/gradients/policy_1/add_2_grad/BroadcastGradientArgsBroadcastGradientArgs-optimizer/gradients/policy_1/add_2_grad/Shape/optimizer/gradients/policy_1/add_2_grad/Shape_1*
T0
�
+optimizer/gradients/policy_1/add_2_grad/SumSum+optimizer/gradients/policy_1/Log_1_grad/mul=optimizer/gradients/policy_1/add_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
/optimizer/gradients/policy_1/add_2_grad/ReshapeReshape+optimizer/gradients/policy_1/add_2_grad/Sum-optimizer/gradients/policy_1/add_2_grad/Shape*
T0*
Tshape0
�
-optimizer/gradients/policy_1/add_2_grad/Sum_1Sum+optimizer/gradients/policy_1/Log_1_grad/mul?optimizer/gradients/policy_1/add_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
1optimizer/gradients/policy_1/add_2_grad/Reshape_1Reshape-optimizer/gradients/policy_1/add_2_grad/Sum_1/optimizer/gradients/policy_1/add_2_grad/Shape_1*
T0*
Tshape0
�
8optimizer/gradients/policy_1/add_2_grad/tuple/group_depsNoOp0^optimizer/gradients/policy_1/add_2_grad/Reshape2^optimizer/gradients/policy_1/add_2_grad/Reshape_1
�
@optimizer/gradients/policy_1/add_2_grad/tuple/control_dependencyIdentity/optimizer/gradients/policy_1/add_2_grad/Reshape9^optimizer/gradients/policy_1/add_2_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients/policy_1/add_2_grad/Reshape
�
Boptimizer/gradients/policy_1/add_2_grad/tuple/control_dependency_1Identity1optimizer/gradients/policy_1/add_2_grad/Reshape_19^optimizer/gradients/policy_1/add_2_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients/policy_1/add_2_grad/Reshape_1
�
Boptimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/ShapeShape'optimizer/main_graph_0/hidden_0/BiasAdd*
T0*
out_type0
�
Doptimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/Shape_1Shape'optimizer/main_graph_0/hidden_0/Sigmoid*
T0*
out_type0
�
Roptimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsBoptimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/ShapeDoptimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/Shape_1*
T0
�
@optimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/MulMulXoptimizer/gradients/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency'optimizer/main_graph_0/hidden_0/Sigmoid*
T0
�
@optimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/SumSum@optimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/MulRoptimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Doptimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/ReshapeReshape@optimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/SumBoptimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/Shape*
T0*
Tshape0
�
Boptimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/Mul_1Mul'optimizer/main_graph_0/hidden_0/BiasAddXoptimizer/gradients/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency*
T0
�
Boptimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/Sum_1SumBoptimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/Mul_1Toptimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Foptimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape_1ReshapeBoptimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/Sum_1Doptimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/Shape_1*
T0*
Tshape0
�
Moptimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/group_depsNoOpE^optimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/ReshapeG^optimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape_1
�
Uoptimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/control_dependencyIdentityDoptimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/ReshapeN^optimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/group_deps*
T0*W
_classM
KIloc:@optimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape
�
Woptimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency_1IdentityFoptimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape_1N^optimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape_1
_
/optimizer/gradients/policy_1/truediv_grad/ShapeShapepolicy_1/Mul*
T0*
out_type0
a
1optimizer/gradients/policy_1/truediv_grad/Shape_1Shapepolicy_1/Sum*
T0*
out_type0
�
?optimizer/gradients/policy_1/truediv_grad/BroadcastGradientArgsBroadcastGradientArgs/optimizer/gradients/policy_1/truediv_grad/Shape1optimizer/gradients/policy_1/truediv_grad/Shape_1*
T0
�
1optimizer/gradients/policy_1/truediv_grad/RealDivRealDiv@optimizer/gradients/policy_1/add_2_grad/tuple/control_dependencypolicy_1/Sum*
T0
�
-optimizer/gradients/policy_1/truediv_grad/SumSum1optimizer/gradients/policy_1/truediv_grad/RealDiv?optimizer/gradients/policy_1/truediv_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
1optimizer/gradients/policy_1/truediv_grad/ReshapeReshape-optimizer/gradients/policy_1/truediv_grad/Sum/optimizer/gradients/policy_1/truediv_grad/Shape*
T0*
Tshape0
K
-optimizer/gradients/policy_1/truediv_grad/NegNegpolicy_1/Mul*
T0
�
3optimizer/gradients/policy_1/truediv_grad/RealDiv_1RealDiv-optimizer/gradients/policy_1/truediv_grad/Negpolicy_1/Sum*
T0
�
3optimizer/gradients/policy_1/truediv_grad/RealDiv_2RealDiv3optimizer/gradients/policy_1/truediv_grad/RealDiv_1policy_1/Sum*
T0
�
-optimizer/gradients/policy_1/truediv_grad/mulMul@optimizer/gradients/policy_1/add_2_grad/tuple/control_dependency3optimizer/gradients/policy_1/truediv_grad/RealDiv_2*
T0
�
/optimizer/gradients/policy_1/truediv_grad/Sum_1Sum-optimizer/gradients/policy_1/truediv_grad/mulAoptimizer/gradients/policy_1/truediv_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients/policy_1/truediv_grad/Reshape_1Reshape/optimizer/gradients/policy_1/truediv_grad/Sum_11optimizer/gradients/policy_1/truediv_grad/Shape_1*
T0*
Tshape0
�
:optimizer/gradients/policy_1/truediv_grad/tuple/group_depsNoOp2^optimizer/gradients/policy_1/truediv_grad/Reshape4^optimizer/gradients/policy_1/truediv_grad/Reshape_1
�
Boptimizer/gradients/policy_1/truediv_grad/tuple/control_dependencyIdentity1optimizer/gradients/policy_1/truediv_grad/Reshape;^optimizer/gradients/policy_1/truediv_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients/policy_1/truediv_grad/Reshape
�
Doptimizer/gradients/policy_1/truediv_grad/tuple/control_dependency_1Identity3optimizer/gradients/policy_1/truediv_grad/Reshape_1;^optimizer/gradients/policy_1/truediv_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients/policy_1/truediv_grad/Reshape_1
�
Loptimizer/gradients/optimizer/main_graph_0/hidden_0/Sigmoid_grad/SigmoidGradSigmoidGrad'optimizer/main_graph_0/hidden_0/SigmoidWoptimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency_1*
T0
[
+optimizer/gradients/policy_1/Sum_grad/ShapeShapepolicy_1/Mul*
T0*
out_type0
�
1optimizer/gradients/policy_1/Sum_grad/BroadcastToBroadcastToDoptimizer/gradients/policy_1/truediv_grad/tuple/control_dependency_1+optimizer/gradients/policy_1/Sum_grad/Shape*
T0*

Tidx0
�
optimizer/gradients/AddN_4AddNUoptimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/control_dependencyLoptimizer/gradients/optimizer/main_graph_0/hidden_0/Sigmoid_grad/SigmoidGrad*
N*
T0*W
_classM
KIloc:@optimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape
�
Loptimizer/gradients/optimizer/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients/AddN_4*
T0*
data_formatNHWC
�
Qoptimizer/gradients/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients/AddN_4M^optimizer/gradients/optimizer/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad
�
Yoptimizer/gradients/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients/AddN_4R^optimizer/gradients/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*W
_classM
KIloc:@optimizer/gradients/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape
�
[optimizer/gradients/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency_1IdentityLoptimizer/gradients/optimizer/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGradR^optimizer/gradients/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*_
_classU
SQloc:@optimizer/gradients/optimizer/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad
�
optimizer/gradients/AddN_5AddNBoptimizer/gradients/policy_1/truediv_grad/tuple/control_dependency1optimizer/gradients/policy_1/Sum_grad/BroadcastTo*
N*
T0*D
_class:
86loc:@optimizer/gradients/policy_1/truediv_grad/Reshape
[
+optimizer/gradients/policy_1/Mul_grad/ShapeShapepolicy_1/add*
T0*
out_type0
g
-optimizer/gradients/policy_1/Mul_grad/Shape_1Shapepolicy_1/strided_slice*
T0*
out_type0
�
;optimizer/gradients/policy_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgs+optimizer/gradients/policy_1/Mul_grad/Shape-optimizer/gradients/policy_1/Mul_grad/Shape_1*
T0
m
)optimizer/gradients/policy_1/Mul_grad/MulMuloptimizer/gradients/AddN_5policy_1/strided_slice*
T0
�
)optimizer/gradients/policy_1/Mul_grad/SumSum)optimizer/gradients/policy_1/Mul_grad/Mul;optimizer/gradients/policy_1/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
-optimizer/gradients/policy_1/Mul_grad/ReshapeReshape)optimizer/gradients/policy_1/Mul_grad/Sum+optimizer/gradients/policy_1/Mul_grad/Shape*
T0*
Tshape0
e
+optimizer/gradients/policy_1/Mul_grad/Mul_1Mulpolicy_1/addoptimizer/gradients/AddN_5*
T0
�
+optimizer/gradients/policy_1/Mul_grad/Sum_1Sum+optimizer/gradients/policy_1/Mul_grad/Mul_1=optimizer/gradients/policy_1/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
/optimizer/gradients/policy_1/Mul_grad/Reshape_1Reshape+optimizer/gradients/policy_1/Mul_grad/Sum_1-optimizer/gradients/policy_1/Mul_grad/Shape_1*
T0*
Tshape0
�
6optimizer/gradients/policy_1/Mul_grad/tuple/group_depsNoOp.^optimizer/gradients/policy_1/Mul_grad/Reshape0^optimizer/gradients/policy_1/Mul_grad/Reshape_1
�
>optimizer/gradients/policy_1/Mul_grad/tuple/control_dependencyIdentity-optimizer/gradients/policy_1/Mul_grad/Reshape7^optimizer/gradients/policy_1/Mul_grad/tuple/group_deps*
T0*@
_class6
42loc:@optimizer/gradients/policy_1/Mul_grad/Reshape
�
@optimizer/gradients/policy_1/Mul_grad/tuple/control_dependency_1Identity/optimizer/gradients/policy_1/Mul_grad/Reshape_17^optimizer/gradients/policy_1/Mul_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients/policy_1/Mul_grad/Reshape_1
�
Foptimizer/gradients/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMulMatMulYoptimizer/gradients/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency,optimizer//main_graph_0/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Hoptimizer/gradients/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMul_1MatMulnormalized_stateYoptimizer/gradients/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Poptimizer/gradients/optimizer/main_graph_0/hidden_0/MatMul_grad/tuple/group_depsNoOpG^optimizer/gradients/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMulI^optimizer/gradients/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMul_1
�
Xoptimizer/gradients/optimizer/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependencyIdentityFoptimizer/gradients/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMulQ^optimizer/gradients/optimizer/main_graph_0/hidden_0/MatMul_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMul
�
Zoptimizer/gradients/optimizer/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependency_1IdentityHoptimizer/gradients/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMul_1Q^optimizer/gradients/optimizer/main_graph_0/hidden_0/MatMul_grad/tuple/group_deps*
T0*[
_classQ
OMloc:@optimizer/gradients/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMul_1
_
+optimizer/gradients/policy_1/add_grad/ShapeShapepolicy_1/Softmax*
T0*
out_type0
_
-optimizer/gradients/policy_1/add_grad/Shape_1Shapepolicy_1/add/y*
T0*
out_type0
�
;optimizer/gradients/policy_1/add_grad/BroadcastGradientArgsBroadcastGradientArgs+optimizer/gradients/policy_1/add_grad/Shape-optimizer/gradients/policy_1/add_grad/Shape_1*
T0
�
)optimizer/gradients/policy_1/add_grad/SumSum>optimizer/gradients/policy_1/Mul_grad/tuple/control_dependency;optimizer/gradients/policy_1/add_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
-optimizer/gradients/policy_1/add_grad/ReshapeReshape)optimizer/gradients/policy_1/add_grad/Sum+optimizer/gradients/policy_1/add_grad/Shape*
T0*
Tshape0
�
+optimizer/gradients/policy_1/add_grad/Sum_1Sum>optimizer/gradients/policy_1/Mul_grad/tuple/control_dependency=optimizer/gradients/policy_1/add_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
/optimizer/gradients/policy_1/add_grad/Reshape_1Reshape+optimizer/gradients/policy_1/add_grad/Sum_1-optimizer/gradients/policy_1/add_grad/Shape_1*
T0*
Tshape0
�
6optimizer/gradients/policy_1/add_grad/tuple/group_depsNoOp.^optimizer/gradients/policy_1/add_grad/Reshape0^optimizer/gradients/policy_1/add_grad/Reshape_1
�
>optimizer/gradients/policy_1/add_grad/tuple/control_dependencyIdentity-optimizer/gradients/policy_1/add_grad/Reshape7^optimizer/gradients/policy_1/add_grad/tuple/group_deps*
T0*@
_class6
42loc:@optimizer/gradients/policy_1/add_grad/Reshape
�
@optimizer/gradients/policy_1/add_grad/tuple/control_dependency_1Identity/optimizer/gradients/policy_1/add_grad/Reshape_17^optimizer/gradients/policy_1/add_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients/policy_1/add_grad/Reshape_1
�
-optimizer/gradients/policy_1/Softmax_grad/mulMul>optimizer/gradients/policy_1/add_grad/tuple/control_dependencypolicy_1/Softmax*
T0
r
?optimizer/gradients/policy_1/Softmax_grad/Sum/reduction_indicesConst*
dtype0*
valueB :
���������
�
-optimizer/gradients/policy_1/Softmax_grad/SumSum-optimizer/gradients/policy_1/Softmax_grad/mul?optimizer/gradients/policy_1/Softmax_grad/Sum/reduction_indices*
T0*

Tidx0*
	keep_dims(
�
-optimizer/gradients/policy_1/Softmax_grad/subSub>optimizer/gradients/policy_1/add_grad/tuple/control_dependency-optimizer/gradients/policy_1/Softmax_grad/Sum*
T0
�
/optimizer/gradients/policy_1/Softmax_grad/mul_1Mul-optimizer/gradients/policy_1/Softmax_grad/subpolicy_1/Softmax*
T0
�
5optimizer/gradients/policy_1/dense/MatMul_grad/MatMulMatMul/optimizer/gradients/policy_1/Softmax_grad/mul_1policy/dense/kernel/read*
T0*
transpose_a( *
transpose_b(
�
7optimizer/gradients/policy_1/dense/MatMul_grad/MatMul_1MatMul policy/main_graph_0/hidden_1/Mul/optimizer/gradients/policy_1/Softmax_grad/mul_1*
T0*
transpose_a(*
transpose_b( 
�
?optimizer/gradients/policy_1/dense/MatMul_grad/tuple/group_depsNoOp6^optimizer/gradients/policy_1/dense/MatMul_grad/MatMul8^optimizer/gradients/policy_1/dense/MatMul_grad/MatMul_1
�
Goptimizer/gradients/policy_1/dense/MatMul_grad/tuple/control_dependencyIdentity5optimizer/gradients/policy_1/dense/MatMul_grad/MatMul@^optimizer/gradients/policy_1/dense/MatMul_grad/tuple/group_deps*
T0*H
_class>
<:loc:@optimizer/gradients/policy_1/dense/MatMul_grad/MatMul
�
Ioptimizer/gradients/policy_1/dense/MatMul_grad/tuple/control_dependency_1Identity7optimizer/gradients/policy_1/dense/MatMul_grad/MatMul_1@^optimizer/gradients/policy_1/dense/MatMul_grad/tuple/group_deps*
T0*J
_class@
><loc:@optimizer/gradients/policy_1/dense/MatMul_grad/MatMul_1
�
?optimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/ShapeShape$policy/main_graph_0/hidden_1/BiasAdd*
T0*
out_type0
�
Aoptimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/Shape_1Shape$policy/main_graph_0/hidden_1/Sigmoid*
T0*
out_type0
�
Ooptimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgs?optimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/ShapeAoptimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/Shape_1*
T0
�
=optimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/MulMulGoptimizer/gradients/policy_1/dense/MatMul_grad/tuple/control_dependency$policy/main_graph_0/hidden_1/Sigmoid*
T0
�
=optimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/SumSum=optimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/MulOoptimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Aoptimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/ReshapeReshape=optimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/Sum?optimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/Shape*
T0*
Tshape0
�
?optimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/Mul_1Mul$policy/main_graph_0/hidden_1/BiasAddGoptimizer/gradients/policy_1/dense/MatMul_grad/tuple/control_dependency*
T0
�
?optimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/Sum_1Sum?optimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/Mul_1Qoptimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Coptimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1Reshape?optimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/Sum_1Aoptimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/Shape_1*
T0*
Tshape0
�
Joptimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/tuple/group_depsNoOpB^optimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/ReshapeD^optimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1
�
Roptimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependencyIdentityAoptimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/ReshapeK^optimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/tuple/group_deps*
T0*T
_classJ
HFloc:@optimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/Reshape
�
Toptimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency_1IdentityCoptimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1K^optimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1
�
Ioptimizer/gradients/policy/main_graph_0/hidden_1/Sigmoid_grad/SigmoidGradSigmoidGrad$policy/main_graph_0/hidden_1/SigmoidToptimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency_1*
T0
�
optimizer/gradients/AddN_6AddNRoptimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependencyIoptimizer/gradients/policy/main_graph_0/hidden_1/Sigmoid_grad/SigmoidGrad*
N*
T0*T
_classJ
HFloc:@optimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/Reshape
�
Ioptimizer/gradients/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients/AddN_6*
T0*
data_formatNHWC
�
Noptimizer/gradients/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients/AddN_6J^optimizer/gradients/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad
�
Voptimizer/gradients/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients/AddN_6O^optimizer/gradients/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*T
_classJ
HFloc:@optimizer/gradients/policy/main_graph_0/hidden_1/Mul_grad/Reshape
�
Xoptimizer/gradients/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency_1IdentityIoptimizer/gradients/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGradO^optimizer/gradients/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*\
_classR
PNloc:@optimizer/gradients/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad
�
Coptimizer/gradients/policy/main_graph_0/hidden_1/MatMul_grad/MatMulMatMulVoptimizer/gradients/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency(policy/main_graph_0/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Eoptimizer/gradients/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1MatMul policy/main_graph_0/hidden_0/MulVoptimizer/gradients/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Moptimizer/gradients/policy/main_graph_0/hidden_1/MatMul_grad/tuple/group_depsNoOpD^optimizer/gradients/policy/main_graph_0/hidden_1/MatMul_grad/MatMulF^optimizer/gradients/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1
�
Uoptimizer/gradients/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependencyIdentityCoptimizer/gradients/policy/main_graph_0/hidden_1/MatMul_grad/MatMulN^optimizer/gradients/policy/main_graph_0/hidden_1/MatMul_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients/policy/main_graph_0/hidden_1/MatMul_grad/MatMul
�
Woptimizer/gradients/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency_1IdentityEoptimizer/gradients/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1N^optimizer/gradients/policy/main_graph_0/hidden_1/MatMul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@optimizer/gradients/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1
�
?optimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/ShapeShape$policy/main_graph_0/hidden_0/BiasAdd*
T0*
out_type0
�
Aoptimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/Shape_1Shape$policy/main_graph_0/hidden_0/Sigmoid*
T0*
out_type0
�
Ooptimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgsBroadcastGradientArgs?optimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/ShapeAoptimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/Shape_1*
T0
�
=optimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/MulMulUoptimizer/gradients/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency$policy/main_graph_0/hidden_0/Sigmoid*
T0
�
=optimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/SumSum=optimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/MulOoptimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Aoptimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/ReshapeReshape=optimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/Sum?optimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/Shape*
T0*
Tshape0
�
?optimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/Mul_1Mul$policy/main_graph_0/hidden_0/BiasAddUoptimizer/gradients/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency*
T0
�
?optimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/Sum_1Sum?optimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/Mul_1Qoptimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Coptimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1Reshape?optimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/Sum_1Aoptimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/Shape_1*
T0*
Tshape0
�
Joptimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/tuple/group_depsNoOpB^optimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/ReshapeD^optimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1
�
Roptimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependencyIdentityAoptimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/ReshapeK^optimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/tuple/group_deps*
T0*T
_classJ
HFloc:@optimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/Reshape
�
Toptimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency_1IdentityCoptimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1K^optimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1
�
Ioptimizer/gradients/policy/main_graph_0/hidden_0/Sigmoid_grad/SigmoidGradSigmoidGrad$policy/main_graph_0/hidden_0/SigmoidToptimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency_1*
T0
�
optimizer/gradients/AddN_7AddNRoptimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependencyIoptimizer/gradients/policy/main_graph_0/hidden_0/Sigmoid_grad/SigmoidGrad*
N*
T0*T
_classJ
HFloc:@optimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/Reshape
�
Ioptimizer/gradients/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients/AddN_7*
T0*
data_formatNHWC
�
Noptimizer/gradients/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients/AddN_7J^optimizer/gradients/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad
�
Voptimizer/gradients/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients/AddN_7O^optimizer/gradients/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*T
_classJ
HFloc:@optimizer/gradients/policy/main_graph_0/hidden_0/Mul_grad/Reshape
�
Xoptimizer/gradients/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency_1IdentityIoptimizer/gradients/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGradO^optimizer/gradients/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*\
_classR
PNloc:@optimizer/gradients/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad
�
Coptimizer/gradients/policy/main_graph_0/hidden_0/MatMul_grad/MatMulMatMulVoptimizer/gradients/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency(policy/main_graph_0/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Eoptimizer/gradients/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1MatMulnormalized_stateVoptimizer/gradients/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Moptimizer/gradients/policy/main_graph_0/hidden_0/MatMul_grad/tuple/group_depsNoOpD^optimizer/gradients/policy/main_graph_0/hidden_0/MatMul_grad/MatMulF^optimizer/gradients/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1
�
Uoptimizer/gradients/policy/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependencyIdentityCoptimizer/gradients/policy/main_graph_0/hidden_0/MatMul_grad/MatMulN^optimizer/gradients/policy/main_graph_0/hidden_0/MatMul_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients/policy/main_graph_0/hidden_0/MatMul_grad/MatMul
�
Woptimizer/gradients/policy/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependency_1IdentityEoptimizer/gradients/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1N^optimizer/gradients/policy/main_graph_0/hidden_0/MatMul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@optimizer/gradients/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1
D
optimizer/gradients_1/ShapeConst*
dtype0*
valueB 
L
optimizer/gradients_1/grad_ys_0Const*
dtype0*
valueB
 *  �?
{
optimizer/gradients_1/FillFilloptimizer/gradients_1/Shapeoptimizer/gradients_1/grad_ys_0*
T0*

index_type0
Z
.optimizer/gradients_1/optimizer/sub_3_grad/NegNegoptimizer/gradients_1/Fill*
T0
�
;optimizer/gradients_1/optimizer/sub_3_grad/tuple/group_depsNoOp^optimizer/gradients_1/Fill/^optimizer/gradients_1/optimizer/sub_3_grad/Neg
�
Coptimizer/gradients_1/optimizer/sub_3_grad/tuple/control_dependencyIdentityoptimizer/gradients_1/Fill<^optimizer/gradients_1/optimizer/sub_3_grad/tuple/group_deps*
T0*-
_class#
!loc:@optimizer/gradients_1/Fill
�
Eoptimizer/gradients_1/optimizer/sub_3_grad/tuple/control_dependency_1Identity.optimizer/gradients_1/optimizer/sub_3_grad/Neg<^optimizer/gradients_1/optimizer/sub_3_grad/tuple/group_deps*
T0*A
_class7
53loc:@optimizer/gradients_1/optimizer/sub_3_grad/Neg
�
;optimizer/gradients_1/optimizer/add_5_grad/tuple/group_depsNoOpD^optimizer/gradients_1/optimizer/sub_3_grad/tuple/control_dependency
�
Coptimizer/gradients_1/optimizer/add_5_grad/tuple/control_dependencyIdentityCoptimizer/gradients_1/optimizer/sub_3_grad/tuple/control_dependency<^optimizer/gradients_1/optimizer/add_5_grad/tuple/group_deps*
T0*-
_class#
!loc:@optimizer/gradients_1/Fill
�
Eoptimizer/gradients_1/optimizer/add_5_grad/tuple/control_dependency_1IdentityCoptimizer/gradients_1/optimizer/sub_3_grad/tuple/control_dependency<^optimizer/gradients_1/optimizer/add_5_grad/tuple/group_deps*
T0*-
_class#
!loc:@optimizer/gradients_1/Fill
�
.optimizer/gradients_1/optimizer/mul_4_grad/MulMulEoptimizer/gradients_1/optimizer/sub_3_grad/tuple/control_dependency_1optimizer/Mean_4*
T0
�
0optimizer/gradients_1/optimizer/mul_4_grad/Mul_1MulEoptimizer/gradients_1/optimizer/sub_3_grad/tuple/control_dependency_1optimizer/PolynomialDecay_2*
T0
�
;optimizer/gradients_1/optimizer/mul_4_grad/tuple/group_depsNoOp/^optimizer/gradients_1/optimizer/mul_4_grad/Mul1^optimizer/gradients_1/optimizer/mul_4_grad/Mul_1
�
Coptimizer/gradients_1/optimizer/mul_4_grad/tuple/control_dependencyIdentity.optimizer/gradients_1/optimizer/mul_4_grad/Mul<^optimizer/gradients_1/optimizer/mul_4_grad/tuple/group_deps*
T0*A
_class7
53loc:@optimizer/gradients_1/optimizer/mul_4_grad/Mul
�
Eoptimizer/gradients_1/optimizer/mul_4_grad/tuple/control_dependency_1Identity0optimizer/gradients_1/optimizer/mul_4_grad/Mul_1<^optimizer/gradients_1/optimizer/mul_4_grad/tuple/group_deps*
T0*C
_class9
75loc:@optimizer/gradients_1/optimizer/mul_4_grad/Mul_1
�
.optimizer/gradients_1/optimizer/Neg_2_grad/NegNegCoptimizer/gradients_1/optimizer/add_5_grad/tuple/control_dependency*
T0
�
.optimizer/gradients_1/optimizer/mul_3_grad/MulMulEoptimizer/gradients_1/optimizer/add_5_grad/tuple/control_dependency_1optimizer/Mean_2*
T0
�
0optimizer/gradients_1/optimizer/mul_3_grad/Mul_1MulEoptimizer/gradients_1/optimizer/add_5_grad/tuple/control_dependency_1optimizer/mul_3/x*
T0
�
;optimizer/gradients_1/optimizer/mul_3_grad/tuple/group_depsNoOp/^optimizer/gradients_1/optimizer/mul_3_grad/Mul1^optimizer/gradients_1/optimizer/mul_3_grad/Mul_1
�
Coptimizer/gradients_1/optimizer/mul_3_grad/tuple/control_dependencyIdentity.optimizer/gradients_1/optimizer/mul_3_grad/Mul<^optimizer/gradients_1/optimizer/mul_3_grad/tuple/group_deps*
T0*A
_class7
53loc:@optimizer/gradients_1/optimizer/mul_3_grad/Mul
�
Eoptimizer/gradients_1/optimizer/mul_3_grad/tuple/control_dependency_1Identity0optimizer/gradients_1/optimizer/mul_3_grad/Mul_1<^optimizer/gradients_1/optimizer/mul_3_grad/tuple/group_deps*
T0*C
_class9
75loc:@optimizer/gradients_1/optimizer/mul_3_grad/Mul_1
g
9optimizer/gradients_1/optimizer/Mean_4_grad/Reshape/shapeConst*
dtype0*
valueB:
�
3optimizer/gradients_1/optimizer/Mean_4_grad/ReshapeReshapeEoptimizer/gradients_1/optimizer/mul_4_grad/tuple/control_dependency_19optimizer/gradients_1/optimizer/Mean_4_grad/Reshape/shape*
T0*
Tshape0
s
1optimizer/gradients_1/optimizer/Mean_4_grad/ShapeShapeoptimizer/DynamicPartition_2:1*
T0*
out_type0
�
0optimizer/gradients_1/optimizer/Mean_4_grad/TileTile3optimizer/gradients_1/optimizer/Mean_4_grad/Reshape1optimizer/gradients_1/optimizer/Mean_4_grad/Shape*
T0*

Tmultiples0
u
3optimizer/gradients_1/optimizer/Mean_4_grad/Shape_1Shapeoptimizer/DynamicPartition_2:1*
T0*
out_type0
\
3optimizer/gradients_1/optimizer/Mean_4_grad/Shape_2Const*
dtype0*
valueB 
_
1optimizer/gradients_1/optimizer/Mean_4_grad/ConstConst*
dtype0*
valueB: 
�
0optimizer/gradients_1/optimizer/Mean_4_grad/ProdProd3optimizer/gradients_1/optimizer/Mean_4_grad/Shape_11optimizer/gradients_1/optimizer/Mean_4_grad/Const*
T0*

Tidx0*
	keep_dims( 
a
3optimizer/gradients_1/optimizer/Mean_4_grad/Const_1Const*
dtype0*
valueB: 
�
2optimizer/gradients_1/optimizer/Mean_4_grad/Prod_1Prod3optimizer/gradients_1/optimizer/Mean_4_grad/Shape_23optimizer/gradients_1/optimizer/Mean_4_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
_
5optimizer/gradients_1/optimizer/Mean_4_grad/Maximum/yConst*
dtype0*
value	B :
�
3optimizer/gradients_1/optimizer/Mean_4_grad/MaximumMaximum2optimizer/gradients_1/optimizer/Mean_4_grad/Prod_15optimizer/gradients_1/optimizer/Mean_4_grad/Maximum/y*
T0
�
4optimizer/gradients_1/optimizer/Mean_4_grad/floordivFloorDiv0optimizer/gradients_1/optimizer/Mean_4_grad/Prod3optimizer/gradients_1/optimizer/Mean_4_grad/Maximum*
T0
�
0optimizer/gradients_1/optimizer/Mean_4_grad/CastCast4optimizer/gradients_1/optimizer/Mean_4_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
�
3optimizer/gradients_1/optimizer/Mean_4_grad/truedivRealDiv0optimizer/gradients_1/optimizer/Mean_4_grad/Tile0optimizer/gradients_1/optimizer/Mean_4_grad/Cast*
T0
n
9optimizer/gradients_1/optimizer/Mean_3_grad/Reshape/shapeConst*
dtype0*
valueB"      
�
3optimizer/gradients_1/optimizer/Mean_3_grad/ReshapeReshape.optimizer/gradients_1/optimizer/Neg_2_grad/Neg9optimizer/gradients_1/optimizer/Mean_3_grad/Reshape/shape*
T0*
Tshape0
s
1optimizer/gradients_1/optimizer/Mean_3_grad/ShapeShapeoptimizer/DynamicPartition_1:1*
T0*
out_type0
�
0optimizer/gradients_1/optimizer/Mean_3_grad/TileTile3optimizer/gradients_1/optimizer/Mean_3_grad/Reshape1optimizer/gradients_1/optimizer/Mean_3_grad/Shape*
T0*

Tmultiples0
u
3optimizer/gradients_1/optimizer/Mean_3_grad/Shape_1Shapeoptimizer/DynamicPartition_1:1*
T0*
out_type0
\
3optimizer/gradients_1/optimizer/Mean_3_grad/Shape_2Const*
dtype0*
valueB 
_
1optimizer/gradients_1/optimizer/Mean_3_grad/ConstConst*
dtype0*
valueB: 
�
0optimizer/gradients_1/optimizer/Mean_3_grad/ProdProd3optimizer/gradients_1/optimizer/Mean_3_grad/Shape_11optimizer/gradients_1/optimizer/Mean_3_grad/Const*
T0*

Tidx0*
	keep_dims( 
a
3optimizer/gradients_1/optimizer/Mean_3_grad/Const_1Const*
dtype0*
valueB: 
�
2optimizer/gradients_1/optimizer/Mean_3_grad/Prod_1Prod3optimizer/gradients_1/optimizer/Mean_3_grad/Shape_23optimizer/gradients_1/optimizer/Mean_3_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
_
5optimizer/gradients_1/optimizer/Mean_3_grad/Maximum/yConst*
dtype0*
value	B :
�
3optimizer/gradients_1/optimizer/Mean_3_grad/MaximumMaximum2optimizer/gradients_1/optimizer/Mean_3_grad/Prod_15optimizer/gradients_1/optimizer/Mean_3_grad/Maximum/y*
T0
�
4optimizer/gradients_1/optimizer/Mean_3_grad/floordivFloorDiv0optimizer/gradients_1/optimizer/Mean_3_grad/Prod3optimizer/gradients_1/optimizer/Mean_3_grad/Maximum*
T0
�
0optimizer/gradients_1/optimizer/Mean_3_grad/CastCast4optimizer/gradients_1/optimizer/Mean_3_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
�
3optimizer/gradients_1/optimizer/Mean_3_grad/truedivRealDiv0optimizer/gradients_1/optimizer/Mean_3_grad/Tile0optimizer/gradients_1/optimizer/Mean_3_grad/Cast*
T0
g
9optimizer/gradients_1/optimizer/Mean_2_grad/Reshape/shapeConst*
dtype0*
valueB:
�
3optimizer/gradients_1/optimizer/Mean_2_grad/ReshapeReshapeEoptimizer/gradients_1/optimizer/mul_3_grad/tuple/control_dependency_19optimizer/gradients_1/optimizer/Mean_2_grad/Reshape/shape*
T0*
Tshape0
_
1optimizer/gradients_1/optimizer/Mean_2_grad/ConstConst*
dtype0*
valueB:
�
0optimizer/gradients_1/optimizer/Mean_2_grad/TileTile3optimizer/gradients_1/optimizer/Mean_2_grad/Reshape1optimizer/gradients_1/optimizer/Mean_2_grad/Const*
T0*

Tmultiples0
`
3optimizer/gradients_1/optimizer/Mean_2_grad/Const_1Const*
dtype0*
valueB
 *  �?
�
3optimizer/gradients_1/optimizer/Mean_2_grad/truedivRealDiv0optimizer/gradients_1/optimizer/Mean_2_grad/Tile3optimizer/gradients_1/optimizer/Mean_2_grad/Const_1*
T0
T
 optimizer/gradients_1/zeros_like	ZerosLikeoptimizer/DynamicPartition_2*
T0
g
=optimizer/gradients_1/optimizer/DynamicPartition_2_grad/ShapeShapeCast_3*
T0*
out_type0
k
=optimizer/gradients_1/optimizer/DynamicPartition_2_grad/ConstConst*
dtype0*
valueB: 
�
<optimizer/gradients_1/optimizer/DynamicPartition_2_grad/ProdProd=optimizer/gradients_1/optimizer/DynamicPartition_2_grad/Shape=optimizer/gradients_1/optimizer/DynamicPartition_2_grad/Const*
T0*

Tidx0*
	keep_dims( 
m
Coptimizer/gradients_1/optimizer/DynamicPartition_2_grad/range/startConst*
dtype0*
value	B : 
m
Coptimizer/gradients_1/optimizer/DynamicPartition_2_grad/range/deltaConst*
dtype0*
value	B :
�
=optimizer/gradients_1/optimizer/DynamicPartition_2_grad/rangeRangeCoptimizer/gradients_1/optimizer/DynamicPartition_2_grad/range/start<optimizer/gradients_1/optimizer/DynamicPartition_2_grad/ProdCoptimizer/gradients_1/optimizer/DynamicPartition_2_grad/range/delta*

Tidx0
�
?optimizer/gradients_1/optimizer/DynamicPartition_2_grad/ReshapeReshape=optimizer/gradients_1/optimizer/DynamicPartition_2_grad/range=optimizer/gradients_1/optimizer/DynamicPartition_2_grad/Shape*
T0*
Tshape0
�
Hoptimizer/gradients_1/optimizer/DynamicPartition_2_grad/DynamicPartitionDynamicPartition?optimizer/gradients_1/optimizer/DynamicPartition_2_grad/ReshapeCast_3*
T0*
num_partitions
�
Moptimizer/gradients_1/optimizer/DynamicPartition_2_grad/ParallelDynamicStitchParallelDynamicStitchHoptimizer/gradients_1/optimizer/DynamicPartition_2_grad/DynamicPartitionJoptimizer/gradients_1/optimizer/DynamicPartition_2_grad/DynamicPartition:1 optimizer/gradients_1/zeros_like3optimizer/gradients_1/optimizer/Mean_4_grad/truediv*
N*
T0
q
?optimizer/gradients_1/optimizer/DynamicPartition_2_grad/Shape_1Shapepolicy_1/Sum_1*
T0*
out_type0
�
Aoptimizer/gradients_1/optimizer/DynamicPartition_2_grad/Reshape_1ReshapeMoptimizer/gradients_1/optimizer/DynamicPartition_2_grad/ParallelDynamicStitch?optimizer/gradients_1/optimizer/DynamicPartition_2_grad/Shape_1*
T0*
Tshape0
V
"optimizer/gradients_1/zeros_like_1	ZerosLikeoptimizer/DynamicPartition_1*
T0
g
=optimizer/gradients_1/optimizer/DynamicPartition_1_grad/ShapeShapeCast_3*
T0*
out_type0
k
=optimizer/gradients_1/optimizer/DynamicPartition_1_grad/ConstConst*
dtype0*
valueB: 
�
<optimizer/gradients_1/optimizer/DynamicPartition_1_grad/ProdProd=optimizer/gradients_1/optimizer/DynamicPartition_1_grad/Shape=optimizer/gradients_1/optimizer/DynamicPartition_1_grad/Const*
T0*

Tidx0*
	keep_dims( 
m
Coptimizer/gradients_1/optimizer/DynamicPartition_1_grad/range/startConst*
dtype0*
value	B : 
m
Coptimizer/gradients_1/optimizer/DynamicPartition_1_grad/range/deltaConst*
dtype0*
value	B :
�
=optimizer/gradients_1/optimizer/DynamicPartition_1_grad/rangeRangeCoptimizer/gradients_1/optimizer/DynamicPartition_1_grad/range/start<optimizer/gradients_1/optimizer/DynamicPartition_1_grad/ProdCoptimizer/gradients_1/optimizer/DynamicPartition_1_grad/range/delta*

Tidx0
�
?optimizer/gradients_1/optimizer/DynamicPartition_1_grad/ReshapeReshape=optimizer/gradients_1/optimizer/DynamicPartition_1_grad/range=optimizer/gradients_1/optimizer/DynamicPartition_1_grad/Shape*
T0*
Tshape0
�
Hoptimizer/gradients_1/optimizer/DynamicPartition_1_grad/DynamicPartitionDynamicPartition?optimizer/gradients_1/optimizer/DynamicPartition_1_grad/ReshapeCast_3*
T0*
num_partitions
�
Moptimizer/gradients_1/optimizer/DynamicPartition_1_grad/ParallelDynamicStitchParallelDynamicStitchHoptimizer/gradients_1/optimizer/DynamicPartition_1_grad/DynamicPartitionJoptimizer/gradients_1/optimizer/DynamicPartition_1_grad/DynamicPartition:1"optimizer/gradients_1/zeros_like_13optimizer/gradients_1/optimizer/Mean_3_grad/truediv*
N*
T0
t
?optimizer/gradients_1/optimizer/DynamicPartition_1_grad/Shape_1Shapeoptimizer/Minimum*
T0*
out_type0
�
Aoptimizer/gradients_1/optimizer/DynamicPartition_1_grad/Reshape_1ReshapeMoptimizer/gradients_1/optimizer/DynamicPartition_1_grad/ParallelDynamicStitch?optimizer/gradients_1/optimizer/DynamicPartition_1_grad/Shape_1*
T0*
Tshape0
�
9optimizer/gradients_1/optimizer/Mean_2/input_grad/unstackUnpack3optimizer/gradients_1/optimizer/Mean_2_grad/truediv*
T0*

axis *	
num
a
/optimizer/gradients_1/policy_1/Sum_1_grad/ShapeShapepolicy_1/stack*
T0*
out_type0
�
.optimizer/gradients_1/policy_1/Sum_1_grad/SizeConst*B
_class8
64loc:@optimizer/gradients_1/policy_1/Sum_1_grad/Shape*
dtype0*
value	B :
�
-optimizer/gradients_1/policy_1/Sum_1_grad/addAddV2 policy_1/Sum_1/reduction_indices.optimizer/gradients_1/policy_1/Sum_1_grad/Size*
T0*B
_class8
64loc:@optimizer/gradients_1/policy_1/Sum_1_grad/Shape
�
-optimizer/gradients_1/policy_1/Sum_1_grad/modFloorMod-optimizer/gradients_1/policy_1/Sum_1_grad/add.optimizer/gradients_1/policy_1/Sum_1_grad/Size*
T0*B
_class8
64loc:@optimizer/gradients_1/policy_1/Sum_1_grad/Shape
�
1optimizer/gradients_1/policy_1/Sum_1_grad/Shape_1Const*B
_class8
64loc:@optimizer/gradients_1/policy_1/Sum_1_grad/Shape*
dtype0*
valueB 
�
5optimizer/gradients_1/policy_1/Sum_1_grad/range/startConst*B
_class8
64loc:@optimizer/gradients_1/policy_1/Sum_1_grad/Shape*
dtype0*
value	B : 
�
5optimizer/gradients_1/policy_1/Sum_1_grad/range/deltaConst*B
_class8
64loc:@optimizer/gradients_1/policy_1/Sum_1_grad/Shape*
dtype0*
value	B :
�
/optimizer/gradients_1/policy_1/Sum_1_grad/rangeRange5optimizer/gradients_1/policy_1/Sum_1_grad/range/start.optimizer/gradients_1/policy_1/Sum_1_grad/Size5optimizer/gradients_1/policy_1/Sum_1_grad/range/delta*

Tidx0*B
_class8
64loc:@optimizer/gradients_1/policy_1/Sum_1_grad/Shape
�
4optimizer/gradients_1/policy_1/Sum_1_grad/Fill/valueConst*B
_class8
64loc:@optimizer/gradients_1/policy_1/Sum_1_grad/Shape*
dtype0*
value	B :
�
.optimizer/gradients_1/policy_1/Sum_1_grad/FillFill1optimizer/gradients_1/policy_1/Sum_1_grad/Shape_14optimizer/gradients_1/policy_1/Sum_1_grad/Fill/value*
T0*B
_class8
64loc:@optimizer/gradients_1/policy_1/Sum_1_grad/Shape*

index_type0
�
7optimizer/gradients_1/policy_1/Sum_1_grad/DynamicStitchDynamicStitch/optimizer/gradients_1/policy_1/Sum_1_grad/range-optimizer/gradients_1/policy_1/Sum_1_grad/mod/optimizer/gradients_1/policy_1/Sum_1_grad/Shape.optimizer/gradients_1/policy_1/Sum_1_grad/Fill*
N*
T0*B
_class8
64loc:@optimizer/gradients_1/policy_1/Sum_1_grad/Shape
�
1optimizer/gradients_1/policy_1/Sum_1_grad/ReshapeReshapeAoptimizer/gradients_1/optimizer/DynamicPartition_2_grad/Reshape_17optimizer/gradients_1/policy_1/Sum_1_grad/DynamicStitch*
T0*
Tshape0
�
5optimizer/gradients_1/policy_1/Sum_1_grad/BroadcastToBroadcastTo1optimizer/gradients_1/policy_1/Sum_1_grad/Reshape/optimizer/gradients_1/policy_1/Sum_1_grad/Shape*
T0*

Tidx0
e
2optimizer/gradients_1/optimizer/Minimum_grad/ShapeShapeoptimizer/mul_1*
T0*
out_type0
g
4optimizer/gradients_1/optimizer/Minimum_grad/Shape_1Shapeoptimizer/mul_2*
T0*
out_type0
�
4optimizer/gradients_1/optimizer/Minimum_grad/Shape_2ShapeAoptimizer/gradients_1/optimizer/DynamicPartition_1_grad/Reshape_1*
T0*
out_type0
e
8optimizer/gradients_1/optimizer/Minimum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
2optimizer/gradients_1/optimizer/Minimum_grad/zerosFill4optimizer/gradients_1/optimizer/Minimum_grad/Shape_28optimizer/gradients_1/optimizer/Minimum_grad/zeros/Const*
T0*

index_type0
n
6optimizer/gradients_1/optimizer/Minimum_grad/LessEqual	LessEqualoptimizer/mul_1optimizer/mul_2*
T0
�
Boptimizer/gradients_1/optimizer/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs2optimizer/gradients_1/optimizer/Minimum_grad/Shape4optimizer/gradients_1/optimizer/Minimum_grad/Shape_1*
T0
�
5optimizer/gradients_1/optimizer/Minimum_grad/SelectV2SelectV26optimizer/gradients_1/optimizer/Minimum_grad/LessEqualAoptimizer/gradients_1/optimizer/DynamicPartition_1_grad/Reshape_12optimizer/gradients_1/optimizer/Minimum_grad/zeros*
T0
�
0optimizer/gradients_1/optimizer/Minimum_grad/SumSum5optimizer/gradients_1/optimizer/Minimum_grad/SelectV2Boptimizer/gradients_1/optimizer/Minimum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_1/optimizer/Minimum_grad/ReshapeReshape0optimizer/gradients_1/optimizer/Minimum_grad/Sum2optimizer/gradients_1/optimizer/Minimum_grad/Shape*
T0*
Tshape0
�
7optimizer/gradients_1/optimizer/Minimum_grad/SelectV2_1SelectV26optimizer/gradients_1/optimizer/Minimum_grad/LessEqual2optimizer/gradients_1/optimizer/Minimum_grad/zerosAoptimizer/gradients_1/optimizer/DynamicPartition_1_grad/Reshape_1*
T0
�
2optimizer/gradients_1/optimizer/Minimum_grad/Sum_1Sum7optimizer/gradients_1/optimizer/Minimum_grad/SelectV2_1Doptimizer/gradients_1/optimizer/Minimum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
6optimizer/gradients_1/optimizer/Minimum_grad/Reshape_1Reshape2optimizer/gradients_1/optimizer/Minimum_grad/Sum_14optimizer/gradients_1/optimizer/Minimum_grad/Shape_1*
T0*
Tshape0
�
=optimizer/gradients_1/optimizer/Minimum_grad/tuple/group_depsNoOp5^optimizer/gradients_1/optimizer/Minimum_grad/Reshape7^optimizer/gradients_1/optimizer/Minimum_grad/Reshape_1
�
Eoptimizer/gradients_1/optimizer/Minimum_grad/tuple/control_dependencyIdentity4optimizer/gradients_1/optimizer/Minimum_grad/Reshape>^optimizer/gradients_1/optimizer/Minimum_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_1/optimizer/Minimum_grad/Reshape
�
Goptimizer/gradients_1/optimizer/Minimum_grad/tuple/control_dependency_1Identity6optimizer/gradients_1/optimizer/Minimum_grad/Reshape_1>^optimizer/gradients_1/optimizer/Minimum_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients_1/optimizer/Minimum_grad/Reshape_1
g
9optimizer/gradients_1/optimizer/Mean_1_grad/Reshape/shapeConst*
dtype0*
valueB:
�
3optimizer/gradients_1/optimizer/Mean_1_grad/ReshapeReshape9optimizer/gradients_1/optimizer/Mean_2/input_grad/unstack9optimizer/gradients_1/optimizer/Mean_1_grad/Reshape/shape*
T0*
Tshape0
q
1optimizer/gradients_1/optimizer/Mean_1_grad/ShapeShapeoptimizer/DynamicPartition:1*
T0*
out_type0
�
0optimizer/gradients_1/optimizer/Mean_1_grad/TileTile3optimizer/gradients_1/optimizer/Mean_1_grad/Reshape1optimizer/gradients_1/optimizer/Mean_1_grad/Shape*
T0*

Tmultiples0
s
3optimizer/gradients_1/optimizer/Mean_1_grad/Shape_1Shapeoptimizer/DynamicPartition:1*
T0*
out_type0
\
3optimizer/gradients_1/optimizer/Mean_1_grad/Shape_2Const*
dtype0*
valueB 
_
1optimizer/gradients_1/optimizer/Mean_1_grad/ConstConst*
dtype0*
valueB: 
�
0optimizer/gradients_1/optimizer/Mean_1_grad/ProdProd3optimizer/gradients_1/optimizer/Mean_1_grad/Shape_11optimizer/gradients_1/optimizer/Mean_1_grad/Const*
T0*

Tidx0*
	keep_dims( 
a
3optimizer/gradients_1/optimizer/Mean_1_grad/Const_1Const*
dtype0*
valueB: 
�
2optimizer/gradients_1/optimizer/Mean_1_grad/Prod_1Prod3optimizer/gradients_1/optimizer/Mean_1_grad/Shape_23optimizer/gradients_1/optimizer/Mean_1_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
_
5optimizer/gradients_1/optimizer/Mean_1_grad/Maximum/yConst*
dtype0*
value	B :
�
3optimizer/gradients_1/optimizer/Mean_1_grad/MaximumMaximum2optimizer/gradients_1/optimizer/Mean_1_grad/Prod_15optimizer/gradients_1/optimizer/Mean_1_grad/Maximum/y*
T0
�
4optimizer/gradients_1/optimizer/Mean_1_grad/floordivFloorDiv0optimizer/gradients_1/optimizer/Mean_1_grad/Prod3optimizer/gradients_1/optimizer/Mean_1_grad/Maximum*
T0
�
0optimizer/gradients_1/optimizer/Mean_1_grad/CastCast4optimizer/gradients_1/optimizer/Mean_1_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
�
3optimizer/gradients_1/optimizer/Mean_1_grad/truedivRealDiv0optimizer/gradients_1/optimizer/Mean_1_grad/Tile0optimizer/gradients_1/optimizer/Mean_1_grad/Cast*
T0
�
1optimizer/gradients_1/policy_1/stack_grad/unstackUnpack5optimizer/gradients_1/policy_1/Sum_1_grad/BroadcastTo*
T0*

axis*	
num
a
0optimizer/gradients_1/optimizer/mul_1_grad/ShapeShapeoptimizer/Exp*
T0*
out_type0
j
2optimizer/gradients_1/optimizer/mul_1_grad/Shape_1Shapeoptimizer/ExpandDims*
T0*
out_type0
�
@optimizer/gradients_1/optimizer/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgs0optimizer/gradients_1/optimizer/mul_1_grad/Shape2optimizer/gradients_1/optimizer/mul_1_grad/Shape_1*
T0
�
.optimizer/gradients_1/optimizer/mul_1_grad/MulMulEoptimizer/gradients_1/optimizer/Minimum_grad/tuple/control_dependencyoptimizer/ExpandDims*
T0
�
.optimizer/gradients_1/optimizer/mul_1_grad/SumSum.optimizer/gradients_1/optimizer/mul_1_grad/Mul@optimizer/gradients_1/optimizer/mul_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients_1/optimizer/mul_1_grad/ReshapeReshape.optimizer/gradients_1/optimizer/mul_1_grad/Sum0optimizer/gradients_1/optimizer/mul_1_grad/Shape*
T0*
Tshape0
�
0optimizer/gradients_1/optimizer/mul_1_grad/Mul_1Muloptimizer/ExpEoptimizer/gradients_1/optimizer/Minimum_grad/tuple/control_dependency*
T0
�
0optimizer/gradients_1/optimizer/mul_1_grad/Sum_1Sum0optimizer/gradients_1/optimizer/mul_1_grad/Mul_1Boptimizer/gradients_1/optimizer/mul_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_1/optimizer/mul_1_grad/Reshape_1Reshape0optimizer/gradients_1/optimizer/mul_1_grad/Sum_12optimizer/gradients_1/optimizer/mul_1_grad/Shape_1*
T0*
Tshape0
�
;optimizer/gradients_1/optimizer/mul_1_grad/tuple/group_depsNoOp3^optimizer/gradients_1/optimizer/mul_1_grad/Reshape5^optimizer/gradients_1/optimizer/mul_1_grad/Reshape_1
�
Coptimizer/gradients_1/optimizer/mul_1_grad/tuple/control_dependencyIdentity2optimizer/gradients_1/optimizer/mul_1_grad/Reshape<^optimizer/gradients_1/optimizer/mul_1_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients_1/optimizer/mul_1_grad/Reshape
�
Eoptimizer/gradients_1/optimizer/mul_1_grad/tuple/control_dependency_1Identity4optimizer/gradients_1/optimizer/mul_1_grad/Reshape_1<^optimizer/gradients_1/optimizer/mul_1_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_1/optimizer/mul_1_grad/Reshape_1
m
0optimizer/gradients_1/optimizer/mul_2_grad/ShapeShapeoptimizer/clip_by_value_1*
T0*
out_type0
j
2optimizer/gradients_1/optimizer/mul_2_grad/Shape_1Shapeoptimizer/ExpandDims*
T0*
out_type0
�
@optimizer/gradients_1/optimizer/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgs0optimizer/gradients_1/optimizer/mul_2_grad/Shape2optimizer/gradients_1/optimizer/mul_2_grad/Shape_1*
T0
�
.optimizer/gradients_1/optimizer/mul_2_grad/MulMulGoptimizer/gradients_1/optimizer/Minimum_grad/tuple/control_dependency_1optimizer/ExpandDims*
T0
�
.optimizer/gradients_1/optimizer/mul_2_grad/SumSum.optimizer/gradients_1/optimizer/mul_2_grad/Mul@optimizer/gradients_1/optimizer/mul_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients_1/optimizer/mul_2_grad/ReshapeReshape.optimizer/gradients_1/optimizer/mul_2_grad/Sum0optimizer/gradients_1/optimizer/mul_2_grad/Shape*
T0*
Tshape0
�
0optimizer/gradients_1/optimizer/mul_2_grad/Mul_1Muloptimizer/clip_by_value_1Goptimizer/gradients_1/optimizer/Minimum_grad/tuple/control_dependency_1*
T0
�
0optimizer/gradients_1/optimizer/mul_2_grad/Sum_1Sum0optimizer/gradients_1/optimizer/mul_2_grad/Mul_1Boptimizer/gradients_1/optimizer/mul_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_1/optimizer/mul_2_grad/Reshape_1Reshape0optimizer/gradients_1/optimizer/mul_2_grad/Sum_12optimizer/gradients_1/optimizer/mul_2_grad/Shape_1*
T0*
Tshape0
�
;optimizer/gradients_1/optimizer/mul_2_grad/tuple/group_depsNoOp3^optimizer/gradients_1/optimizer/mul_2_grad/Reshape5^optimizer/gradients_1/optimizer/mul_2_grad/Reshape_1
�
Coptimizer/gradients_1/optimizer/mul_2_grad/tuple/control_dependencyIdentity2optimizer/gradients_1/optimizer/mul_2_grad/Reshape<^optimizer/gradients_1/optimizer/mul_2_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients_1/optimizer/mul_2_grad/Reshape
�
Eoptimizer/gradients_1/optimizer/mul_2_grad/tuple/control_dependency_1Identity4optimizer/gradients_1/optimizer/mul_2_grad/Reshape_1<^optimizer/gradients_1/optimizer/mul_2_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_1/optimizer/mul_2_grad/Reshape_1
T
"optimizer/gradients_1/zeros_like_2	ZerosLikeoptimizer/DynamicPartition*
T0
e
;optimizer/gradients_1/optimizer/DynamicPartition_grad/ShapeShapeCast_3*
T0*
out_type0
i
;optimizer/gradients_1/optimizer/DynamicPartition_grad/ConstConst*
dtype0*
valueB: 
�
:optimizer/gradients_1/optimizer/DynamicPartition_grad/ProdProd;optimizer/gradients_1/optimizer/DynamicPartition_grad/Shape;optimizer/gradients_1/optimizer/DynamicPartition_grad/Const*
T0*

Tidx0*
	keep_dims( 
k
Aoptimizer/gradients_1/optimizer/DynamicPartition_grad/range/startConst*
dtype0*
value	B : 
k
Aoptimizer/gradients_1/optimizer/DynamicPartition_grad/range/deltaConst*
dtype0*
value	B :
�
;optimizer/gradients_1/optimizer/DynamicPartition_grad/rangeRangeAoptimizer/gradients_1/optimizer/DynamicPartition_grad/range/start:optimizer/gradients_1/optimizer/DynamicPartition_grad/ProdAoptimizer/gradients_1/optimizer/DynamicPartition_grad/range/delta*

Tidx0
�
=optimizer/gradients_1/optimizer/DynamicPartition_grad/ReshapeReshape;optimizer/gradients_1/optimizer/DynamicPartition_grad/range;optimizer/gradients_1/optimizer/DynamicPartition_grad/Shape*
T0*
Tshape0
�
Foptimizer/gradients_1/optimizer/DynamicPartition_grad/DynamicPartitionDynamicPartition=optimizer/gradients_1/optimizer/DynamicPartition_grad/ReshapeCast_3*
T0*
num_partitions
�
Koptimizer/gradients_1/optimizer/DynamicPartition_grad/ParallelDynamicStitchParallelDynamicStitchFoptimizer/gradients_1/optimizer/DynamicPartition_grad/DynamicPartitionHoptimizer/gradients_1/optimizer/DynamicPartition_grad/DynamicPartition:1"optimizer/gradients_1/zeros_like_23optimizer/gradients_1/optimizer/Mean_1_grad/truediv*
N*
T0
r
=optimizer/gradients_1/optimizer/DynamicPartition_grad/Shape_1Shapeoptimizer/Maximum*
T0*
out_type0
�
?optimizer/gradients_1/optimizer/DynamicPartition_grad/Reshape_1ReshapeKoptimizer/gradients_1/optimizer/DynamicPartition_grad/ParallelDynamicStitch=optimizer/gradients_1/optimizer/DynamicPartition_grad/Shape_1*
T0*
Tshape0
�
Uoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits/Reshape_2_grad/ShapeShape*policy_1/softmax_cross_entropy_with_logits*
T0*
out_type0
�
Woptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits/Reshape_2_grad/ReshapeReshape1optimizer/gradients_1/policy_1/stack_grad/unstackUoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits/Reshape_2_grad/Shape*
T0*
Tshape0

:optimizer/gradients_1/optimizer/clip_by_value_1_grad/ShapeShape!optimizer/clip_by_value_1/Minimum*
T0*
out_type0
e
<optimizer/gradients_1/optimizer/clip_by_value_1_grad/Shape_1Const*
dtype0*
valueB 
�
<optimizer/gradients_1/optimizer/clip_by_value_1_grad/Shape_2ShapeCoptimizer/gradients_1/optimizer/mul_2_grad/tuple/control_dependency*
T0*
out_type0
m
@optimizer/gradients_1/optimizer/clip_by_value_1_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
:optimizer/gradients_1/optimizer/clip_by_value_1_grad/zerosFill<optimizer/gradients_1/optimizer/clip_by_value_1_grad/Shape_2@optimizer/gradients_1/optimizer/clip_by_value_1_grad/zeros/Const*
T0*

index_type0
�
Aoptimizer/gradients_1/optimizer/clip_by_value_1_grad/GreaterEqualGreaterEqual!optimizer/clip_by_value_1/Minimumoptimizer/sub_2*
T0
�
Joptimizer/gradients_1/optimizer/clip_by_value_1_grad/BroadcastGradientArgsBroadcastGradientArgs:optimizer/gradients_1/optimizer/clip_by_value_1_grad/Shape<optimizer/gradients_1/optimizer/clip_by_value_1_grad/Shape_1*
T0
�
=optimizer/gradients_1/optimizer/clip_by_value_1_grad/SelectV2SelectV2Aoptimizer/gradients_1/optimizer/clip_by_value_1_grad/GreaterEqualCoptimizer/gradients_1/optimizer/mul_2_grad/tuple/control_dependency:optimizer/gradients_1/optimizer/clip_by_value_1_grad/zeros*
T0
�
8optimizer/gradients_1/optimizer/clip_by_value_1_grad/SumSum=optimizer/gradients_1/optimizer/clip_by_value_1_grad/SelectV2Joptimizer/gradients_1/optimizer/clip_by_value_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
<optimizer/gradients_1/optimizer/clip_by_value_1_grad/ReshapeReshape8optimizer/gradients_1/optimizer/clip_by_value_1_grad/Sum:optimizer/gradients_1/optimizer/clip_by_value_1_grad/Shape*
T0*
Tshape0
�
?optimizer/gradients_1/optimizer/clip_by_value_1_grad/SelectV2_1SelectV2Aoptimizer/gradients_1/optimizer/clip_by_value_1_grad/GreaterEqual:optimizer/gradients_1/optimizer/clip_by_value_1_grad/zerosCoptimizer/gradients_1/optimizer/mul_2_grad/tuple/control_dependency*
T0
�
:optimizer/gradients_1/optimizer/clip_by_value_1_grad/Sum_1Sum?optimizer/gradients_1/optimizer/clip_by_value_1_grad/SelectV2_1Loptimizer/gradients_1/optimizer/clip_by_value_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
>optimizer/gradients_1/optimizer/clip_by_value_1_grad/Reshape_1Reshape:optimizer/gradients_1/optimizer/clip_by_value_1_grad/Sum_1<optimizer/gradients_1/optimizer/clip_by_value_1_grad/Shape_1*
T0*
Tshape0
�
Eoptimizer/gradients_1/optimizer/clip_by_value_1_grad/tuple/group_depsNoOp=^optimizer/gradients_1/optimizer/clip_by_value_1_grad/Reshape?^optimizer/gradients_1/optimizer/clip_by_value_1_grad/Reshape_1
�
Moptimizer/gradients_1/optimizer/clip_by_value_1_grad/tuple/control_dependencyIdentity<optimizer/gradients_1/optimizer/clip_by_value_1_grad/ReshapeF^optimizer/gradients_1/optimizer/clip_by_value_1_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_1/optimizer/clip_by_value_1_grad/Reshape
�
Ooptimizer/gradients_1/optimizer/clip_by_value_1_grad/tuple/control_dependency_1Identity>optimizer/gradients_1/optimizer/clip_by_value_1_grad/Reshape_1F^optimizer/gradients_1/optimizer/clip_by_value_1_grad/tuple/group_deps*
T0*Q
_classG
ECloc:@optimizer/gradients_1/optimizer/clip_by_value_1_grad/Reshape_1
q
2optimizer/gradients_1/optimizer/Maximum_grad/ShapeShapeoptimizer/SquaredDifference*
T0*
out_type0
u
4optimizer/gradients_1/optimizer/Maximum_grad/Shape_1Shapeoptimizer/SquaredDifference_1*
T0*
out_type0
�
4optimizer/gradients_1/optimizer/Maximum_grad/Shape_2Shape?optimizer/gradients_1/optimizer/DynamicPartition_grad/Reshape_1*
T0*
out_type0
e
8optimizer/gradients_1/optimizer/Maximum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
2optimizer/gradients_1/optimizer/Maximum_grad/zerosFill4optimizer/gradients_1/optimizer/Maximum_grad/Shape_28optimizer/gradients_1/optimizer/Maximum_grad/zeros/Const*
T0*

index_type0
�
9optimizer/gradients_1/optimizer/Maximum_grad/GreaterEqualGreaterEqualoptimizer/SquaredDifferenceoptimizer/SquaredDifference_1*
T0
�
Boptimizer/gradients_1/optimizer/Maximum_grad/BroadcastGradientArgsBroadcastGradientArgs2optimizer/gradients_1/optimizer/Maximum_grad/Shape4optimizer/gradients_1/optimizer/Maximum_grad/Shape_1*
T0
�
5optimizer/gradients_1/optimizer/Maximum_grad/SelectV2SelectV29optimizer/gradients_1/optimizer/Maximum_grad/GreaterEqual?optimizer/gradients_1/optimizer/DynamicPartition_grad/Reshape_12optimizer/gradients_1/optimizer/Maximum_grad/zeros*
T0
�
0optimizer/gradients_1/optimizer/Maximum_grad/SumSum5optimizer/gradients_1/optimizer/Maximum_grad/SelectV2Boptimizer/gradients_1/optimizer/Maximum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_1/optimizer/Maximum_grad/ReshapeReshape0optimizer/gradients_1/optimizer/Maximum_grad/Sum2optimizer/gradients_1/optimizer/Maximum_grad/Shape*
T0*
Tshape0
�
7optimizer/gradients_1/optimizer/Maximum_grad/SelectV2_1SelectV29optimizer/gradients_1/optimizer/Maximum_grad/GreaterEqual2optimizer/gradients_1/optimizer/Maximum_grad/zeros?optimizer/gradients_1/optimizer/DynamicPartition_grad/Reshape_1*
T0
�
2optimizer/gradients_1/optimizer/Maximum_grad/Sum_1Sum7optimizer/gradients_1/optimizer/Maximum_grad/SelectV2_1Doptimizer/gradients_1/optimizer/Maximum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
6optimizer/gradients_1/optimizer/Maximum_grad/Reshape_1Reshape2optimizer/gradients_1/optimizer/Maximum_grad/Sum_14optimizer/gradients_1/optimizer/Maximum_grad/Shape_1*
T0*
Tshape0
�
=optimizer/gradients_1/optimizer/Maximum_grad/tuple/group_depsNoOp5^optimizer/gradients_1/optimizer/Maximum_grad/Reshape7^optimizer/gradients_1/optimizer/Maximum_grad/Reshape_1
�
Eoptimizer/gradients_1/optimizer/Maximum_grad/tuple/control_dependencyIdentity4optimizer/gradients_1/optimizer/Maximum_grad/Reshape>^optimizer/gradients_1/optimizer/Maximum_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_1/optimizer/Maximum_grad/Reshape
�
Goptimizer/gradients_1/optimizer/Maximum_grad/tuple/control_dependency_1Identity6optimizer/gradients_1/optimizer/Maximum_grad/Reshape_1>^optimizer/gradients_1/optimizer/Maximum_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients_1/optimizer/Maximum_grad/Reshape_1
f
"optimizer/gradients_1/zeros_like_3	ZerosLike,policy_1/softmax_cross_entropy_with_logits:1*
T0
�
Toptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/ExpandDims/dimConst*
dtype0*
valueB :
���������
�
Poptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/ExpandDims
ExpandDimsWoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits/Reshape_2_grad/ReshapeToptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/ExpandDims/dim*
T0*

Tdim0
�
Ioptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/mulMulPoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/ExpandDims,policy_1/softmax_cross_entropy_with_logits:1*
T0
�
Poptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/LogSoftmax
LogSoftmax2policy_1/softmax_cross_entropy_with_logits/Reshape*
T0
�
Ioptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/NegNegPoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/LogSoftmax*
T0
�
Voptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/ExpandDims_1/dimConst*
dtype0*
valueB :
���������
�
Roptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/ExpandDims_1
ExpandDimsWoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits/Reshape_2_grad/ReshapeVoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/ExpandDims_1/dim*
T0*

Tdim0
�
Koptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/mul_1MulRoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/ExpandDims_1Ioptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/Neg*
T0
�
Voptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/tuple/group_depsNoOpJ^optimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/mulL^optimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/mul_1
�
^optimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/tuple/control_dependencyIdentityIoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/mulW^optimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/tuple/group_deps*
T0*\
_classR
PNloc:@optimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/mul
�
`optimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/tuple/control_dependency_1IdentityKoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/mul_1W^optimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/tuple/group_deps*
T0*^
_classT
RPloc:@optimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/mul_1
s
Boptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/ShapeShapeoptimizer/Exp*
T0*
out_type0
m
Doptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/Shape_1Const*
dtype0*
valueB 
�
Doptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/Shape_2ShapeMoptimizer/gradients_1/optimizer/clip_by_value_1_grad/tuple/control_dependency*
T0*
out_type0
u
Hoptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
Boptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/zerosFillDoptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/Shape_2Hoptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/zeros/Const*
T0*

index_type0
|
Foptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/LessEqual	LessEqualoptimizer/Expoptimizer/add_4*
T0
�
Roptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgsBoptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/ShapeDoptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/Shape_1*
T0
�
Eoptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/SelectV2SelectV2Foptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/LessEqualMoptimizer/gradients_1/optimizer/clip_by_value_1_grad/tuple/control_dependencyBoptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/zeros*
T0
�
@optimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/SumSumEoptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/SelectV2Roptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Doptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/ReshapeReshape@optimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/SumBoptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/Shape*
T0*
Tshape0
�
Goptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/SelectV2_1SelectV2Foptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/LessEqualBoptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/zerosMoptimizer/gradients_1/optimizer/clip_by_value_1_grad/tuple/control_dependency*
T0
�
Boptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/Sum_1SumGoptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/SelectV2_1Toptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Foptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/Reshape_1ReshapeBoptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/Sum_1Doptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/Shape_1*
T0*
Tshape0
�
Moptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/tuple/group_depsNoOpE^optimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/ReshapeG^optimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/Reshape_1
�
Uoptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/tuple/control_dependencyIdentityDoptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/ReshapeN^optimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/tuple/group_deps*
T0*W
_classM
KIloc:@optimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/Reshape
�
Woptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/tuple/control_dependency_1IdentityFoptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/Reshape_1N^optimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/Reshape_1
�
=optimizer/gradients_1/optimizer/SquaredDifference_grad/scalarConstF^optimizer/gradients_1/optimizer/Maximum_grad/tuple/control_dependency*
dtype0*
valueB
 *   @
�
:optimizer/gradients_1/optimizer/SquaredDifference_grad/MulMul=optimizer/gradients_1/optimizer/SquaredDifference_grad/scalarEoptimizer/gradients_1/optimizer/Maximum_grad/tuple/control_dependency*
T0
�
:optimizer/gradients_1/optimizer/SquaredDifference_grad/subSuboptimizer/extrinsic_returnsoptimizer/Sum_3F^optimizer/gradients_1/optimizer/Maximum_grad/tuple/control_dependency*
T0
�
<optimizer/gradients_1/optimizer/SquaredDifference_grad/mul_1Mul:optimizer/gradients_1/optimizer/SquaredDifference_grad/Mul:optimizer/gradients_1/optimizer/SquaredDifference_grad/sub*
T0
{
<optimizer/gradients_1/optimizer/SquaredDifference_grad/ShapeShapeoptimizer/extrinsic_returns*
T0*
out_type0
q
>optimizer/gradients_1/optimizer/SquaredDifference_grad/Shape_1Shapeoptimizer/Sum_3*
T0*
out_type0
�
Loptimizer/gradients_1/optimizer/SquaredDifference_grad/BroadcastGradientArgsBroadcastGradientArgs<optimizer/gradients_1/optimizer/SquaredDifference_grad/Shape>optimizer/gradients_1/optimizer/SquaredDifference_grad/Shape_1*
T0
�
:optimizer/gradients_1/optimizer/SquaredDifference_grad/SumSum<optimizer/gradients_1/optimizer/SquaredDifference_grad/mul_1Loptimizer/gradients_1/optimizer/SquaredDifference_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
>optimizer/gradients_1/optimizer/SquaredDifference_grad/ReshapeReshape:optimizer/gradients_1/optimizer/SquaredDifference_grad/Sum<optimizer/gradients_1/optimizer/SquaredDifference_grad/Shape*
T0*
Tshape0
�
<optimizer/gradients_1/optimizer/SquaredDifference_grad/Sum_1Sum<optimizer/gradients_1/optimizer/SquaredDifference_grad/mul_1Noptimizer/gradients_1/optimizer/SquaredDifference_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
@optimizer/gradients_1/optimizer/SquaredDifference_grad/Reshape_1Reshape<optimizer/gradients_1/optimizer/SquaredDifference_grad/Sum_1>optimizer/gradients_1/optimizer/SquaredDifference_grad/Shape_1*
T0*
Tshape0
�
:optimizer/gradients_1/optimizer/SquaredDifference_grad/NegNeg@optimizer/gradients_1/optimizer/SquaredDifference_grad/Reshape_1*
T0
�
Goptimizer/gradients_1/optimizer/SquaredDifference_grad/tuple/group_depsNoOp;^optimizer/gradients_1/optimizer/SquaredDifference_grad/Neg?^optimizer/gradients_1/optimizer/SquaredDifference_grad/Reshape
�
Ooptimizer/gradients_1/optimizer/SquaredDifference_grad/tuple/control_dependencyIdentity>optimizer/gradients_1/optimizer/SquaredDifference_grad/ReshapeH^optimizer/gradients_1/optimizer/SquaredDifference_grad/tuple/group_deps*
T0*Q
_classG
ECloc:@optimizer/gradients_1/optimizer/SquaredDifference_grad/Reshape
�
Qoptimizer/gradients_1/optimizer/SquaredDifference_grad/tuple/control_dependency_1Identity:optimizer/gradients_1/optimizer/SquaredDifference_grad/NegH^optimizer/gradients_1/optimizer/SquaredDifference_grad/tuple/group_deps*
T0*M
_classC
A?loc:@optimizer/gradients_1/optimizer/SquaredDifference_grad/Neg
�
?optimizer/gradients_1/optimizer/SquaredDifference_1_grad/scalarConstH^optimizer/gradients_1/optimizer/Maximum_grad/tuple/control_dependency_1*
dtype0*
valueB
 *   @
�
<optimizer/gradients_1/optimizer/SquaredDifference_1_grad/MulMul?optimizer/gradients_1/optimizer/SquaredDifference_1_grad/scalarGoptimizer/gradients_1/optimizer/Maximum_grad/tuple/control_dependency_1*
T0
�
<optimizer/gradients_1/optimizer/SquaredDifference_1_grad/subSuboptimizer/extrinsic_returnsoptimizer/add_3H^optimizer/gradients_1/optimizer/Maximum_grad/tuple/control_dependency_1*
T0
�
>optimizer/gradients_1/optimizer/SquaredDifference_1_grad/mul_1Mul<optimizer/gradients_1/optimizer/SquaredDifference_1_grad/Mul<optimizer/gradients_1/optimizer/SquaredDifference_1_grad/sub*
T0
}
>optimizer/gradients_1/optimizer/SquaredDifference_1_grad/ShapeShapeoptimizer/extrinsic_returns*
T0*
out_type0
s
@optimizer/gradients_1/optimizer/SquaredDifference_1_grad/Shape_1Shapeoptimizer/add_3*
T0*
out_type0
�
Noptimizer/gradients_1/optimizer/SquaredDifference_1_grad/BroadcastGradientArgsBroadcastGradientArgs>optimizer/gradients_1/optimizer/SquaredDifference_1_grad/Shape@optimizer/gradients_1/optimizer/SquaredDifference_1_grad/Shape_1*
T0
�
<optimizer/gradients_1/optimizer/SquaredDifference_1_grad/SumSum>optimizer/gradients_1/optimizer/SquaredDifference_1_grad/mul_1Noptimizer/gradients_1/optimizer/SquaredDifference_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
@optimizer/gradients_1/optimizer/SquaredDifference_1_grad/ReshapeReshape<optimizer/gradients_1/optimizer/SquaredDifference_1_grad/Sum>optimizer/gradients_1/optimizer/SquaredDifference_1_grad/Shape*
T0*
Tshape0
�
>optimizer/gradients_1/optimizer/SquaredDifference_1_grad/Sum_1Sum>optimizer/gradients_1/optimizer/SquaredDifference_1_grad/mul_1Poptimizer/gradients_1/optimizer/SquaredDifference_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Boptimizer/gradients_1/optimizer/SquaredDifference_1_grad/Reshape_1Reshape>optimizer/gradients_1/optimizer/SquaredDifference_1_grad/Sum_1@optimizer/gradients_1/optimizer/SquaredDifference_1_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_1/optimizer/SquaredDifference_1_grad/NegNegBoptimizer/gradients_1/optimizer/SquaredDifference_1_grad/Reshape_1*
T0
�
Ioptimizer/gradients_1/optimizer/SquaredDifference_1_grad/tuple/group_depsNoOp=^optimizer/gradients_1/optimizer/SquaredDifference_1_grad/NegA^optimizer/gradients_1/optimizer/SquaredDifference_1_grad/Reshape
�
Qoptimizer/gradients_1/optimizer/SquaredDifference_1_grad/tuple/control_dependencyIdentity@optimizer/gradients_1/optimizer/SquaredDifference_1_grad/ReshapeJ^optimizer/gradients_1/optimizer/SquaredDifference_1_grad/tuple/group_deps*
T0*S
_classI
GEloc:@optimizer/gradients_1/optimizer/SquaredDifference_1_grad/Reshape
�
Soptimizer/gradients_1/optimizer/SquaredDifference_1_grad/tuple/control_dependency_1Identity<optimizer/gradients_1/optimizer/SquaredDifference_1_grad/NegJ^optimizer/gradients_1/optimizer/SquaredDifference_1_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_1/optimizer/SquaredDifference_1_grad/Neg
�
Soptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits/Reshape_grad/ShapeShapepolicy_1/strided_slice_3*
T0*
out_type0
�
Uoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits/Reshape_grad/ReshapeReshape^optimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/tuple/control_dependencySoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits/Reshape_grad/Shape*
T0*
Tshape0
�
Uoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits/Reshape_1_grad/ShapeShapepolicy_1/Softmax_1*
T0*
out_type0
�
Woptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits/Reshape_1_grad/ReshapeReshape`optimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_grad/tuple/control_dependency_1Uoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits/Reshape_1_grad/Shape*
T0*
Tshape0
�
optimizer/gradients_1/AddNAddNCoptimizer/gradients_1/optimizer/mul_1_grad/tuple/control_dependencyUoptimizer/gradients_1/optimizer/clip_by_value_1/Minimum_grad/tuple/control_dependency*
N*
T0*E
_class;
97loc:@optimizer/gradients_1/optimizer/mul_1_grad/Reshape
g
,optimizer/gradients_1/optimizer/Exp_grad/mulMuloptimizer/gradients_1/AddNoptimizer/Exp*
T0
u
0optimizer/gradients_1/optimizer/Sum_3_grad/ShapeShape!optimizer/extrinsic_value/BiasAdd*
T0*
out_type0
�
/optimizer/gradients_1/optimizer/Sum_3_grad/SizeConst*C
_class9
75loc:@optimizer/gradients_1/optimizer/Sum_3_grad/Shape*
dtype0*
value	B :
�
.optimizer/gradients_1/optimizer/Sum_3_grad/addAddV2!optimizer/Sum_3/reduction_indices/optimizer/gradients_1/optimizer/Sum_3_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_1/optimizer/Sum_3_grad/Shape
�
.optimizer/gradients_1/optimizer/Sum_3_grad/modFloorMod.optimizer/gradients_1/optimizer/Sum_3_grad/add/optimizer/gradients_1/optimizer/Sum_3_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_1/optimizer/Sum_3_grad/Shape
�
2optimizer/gradients_1/optimizer/Sum_3_grad/Shape_1Const*C
_class9
75loc:@optimizer/gradients_1/optimizer/Sum_3_grad/Shape*
dtype0*
valueB 
�
6optimizer/gradients_1/optimizer/Sum_3_grad/range/startConst*C
_class9
75loc:@optimizer/gradients_1/optimizer/Sum_3_grad/Shape*
dtype0*
value	B : 
�
6optimizer/gradients_1/optimizer/Sum_3_grad/range/deltaConst*C
_class9
75loc:@optimizer/gradients_1/optimizer/Sum_3_grad/Shape*
dtype0*
value	B :
�
0optimizer/gradients_1/optimizer/Sum_3_grad/rangeRange6optimizer/gradients_1/optimizer/Sum_3_grad/range/start/optimizer/gradients_1/optimizer/Sum_3_grad/Size6optimizer/gradients_1/optimizer/Sum_3_grad/range/delta*

Tidx0*C
_class9
75loc:@optimizer/gradients_1/optimizer/Sum_3_grad/Shape
�
5optimizer/gradients_1/optimizer/Sum_3_grad/Fill/valueConst*C
_class9
75loc:@optimizer/gradients_1/optimizer/Sum_3_grad/Shape*
dtype0*
value	B :
�
/optimizer/gradients_1/optimizer/Sum_3_grad/FillFill2optimizer/gradients_1/optimizer/Sum_3_grad/Shape_15optimizer/gradients_1/optimizer/Sum_3_grad/Fill/value*
T0*C
_class9
75loc:@optimizer/gradients_1/optimizer/Sum_3_grad/Shape*

index_type0
�
8optimizer/gradients_1/optimizer/Sum_3_grad/DynamicStitchDynamicStitch0optimizer/gradients_1/optimizer/Sum_3_grad/range.optimizer/gradients_1/optimizer/Sum_3_grad/mod0optimizer/gradients_1/optimizer/Sum_3_grad/Shape/optimizer/gradients_1/optimizer/Sum_3_grad/Fill*
N*
T0*C
_class9
75loc:@optimizer/gradients_1/optimizer/Sum_3_grad/Shape
�
2optimizer/gradients_1/optimizer/Sum_3_grad/ReshapeReshapeQoptimizer/gradients_1/optimizer/SquaredDifference_grad/tuple/control_dependency_18optimizer/gradients_1/optimizer/Sum_3_grad/DynamicStitch*
T0*
Tshape0
�
6optimizer/gradients_1/optimizer/Sum_3_grad/BroadcastToBroadcastTo2optimizer/gradients_1/optimizer/Sum_3_grad/Reshape0optimizer/gradients_1/optimizer/Sum_3_grad/Shape*
T0*

Tidx0
v
0optimizer/gradients_1/optimizer/add_3_grad/ShapeShape"optimizer/extrinsic_value_estimate*
T0*
out_type0
m
2optimizer/gradients_1/optimizer/add_3_grad/Shape_1Shapeoptimizer/clip_by_value*
T0*
out_type0
�
@optimizer/gradients_1/optimizer/add_3_grad/BroadcastGradientArgsBroadcastGradientArgs0optimizer/gradients_1/optimizer/add_3_grad/Shape2optimizer/gradients_1/optimizer/add_3_grad/Shape_1*
T0
�
.optimizer/gradients_1/optimizer/add_3_grad/SumSumSoptimizer/gradients_1/optimizer/SquaredDifference_1_grad/tuple/control_dependency_1@optimizer/gradients_1/optimizer/add_3_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients_1/optimizer/add_3_grad/ReshapeReshape.optimizer/gradients_1/optimizer/add_3_grad/Sum0optimizer/gradients_1/optimizer/add_3_grad/Shape*
T0*
Tshape0
�
0optimizer/gradients_1/optimizer/add_3_grad/Sum_1SumSoptimizer/gradients_1/optimizer/SquaredDifference_1_grad/tuple/control_dependency_1Boptimizer/gradients_1/optimizer/add_3_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_1/optimizer/add_3_grad/Reshape_1Reshape0optimizer/gradients_1/optimizer/add_3_grad/Sum_12optimizer/gradients_1/optimizer/add_3_grad/Shape_1*
T0*
Tshape0
�
;optimizer/gradients_1/optimizer/add_3_grad/tuple/group_depsNoOp3^optimizer/gradients_1/optimizer/add_3_grad/Reshape5^optimizer/gradients_1/optimizer/add_3_grad/Reshape_1
�
Coptimizer/gradients_1/optimizer/add_3_grad/tuple/control_dependencyIdentity2optimizer/gradients_1/optimizer/add_3_grad/Reshape<^optimizer/gradients_1/optimizer/add_3_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients_1/optimizer/add_3_grad/Reshape
�
Eoptimizer/gradients_1/optimizer/add_3_grad/tuple/control_dependency_1Identity4optimizer/gradients_1/optimizer/add_3_grad/Reshape_1<^optimizer/gradients_1/optimizer/add_3_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_1/optimizer/add_3_grad/Reshape_1
u
9optimizer/gradients_1/policy_1/strided_slice_3_grad/ShapeShapepolicy_1/concat_2/concat*
T0*
out_type0

Joptimizer/gradients_1/policy_1/strided_slice_3_grad/StridedSliceGrad/beginConst*
dtype0*
valueB"        
}
Hoptimizer/gradients_1/policy_1/strided_slice_3_grad/StridedSliceGrad/endConst*
dtype0*
valueB"       
�
Loptimizer/gradients_1/policy_1/strided_slice_3_grad/StridedSliceGrad/stridesConst*
dtype0*
valueB"      
�
Doptimizer/gradients_1/policy_1/strided_slice_3_grad/StridedSliceGradStridedSliceGrad9optimizer/gradients_1/policy_1/strided_slice_3_grad/ShapeJoptimizer/gradients_1/policy_1/strided_slice_3_grad/StridedSliceGrad/beginHoptimizer/gradients_1/policy_1/strided_slice_3_grad/StridedSliceGrad/endLoptimizer/gradients_1/policy_1/strided_slice_3_grad/StridedSliceGrad/stridesUoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits/Reshape_grad/Reshape*
Index0*
T0*

begin_mask*
ellipsis_mask *
end_mask*
new_axis_mask *
shrink_axis_mask 
�
1optimizer/gradients_1/policy_1/Softmax_1_grad/mulMulWoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits/Reshape_1_grad/Reshapepolicy_1/Softmax_1*
T0
v
Coptimizer/gradients_1/policy_1/Softmax_1_grad/Sum/reduction_indicesConst*
dtype0*
valueB :
���������
�
1optimizer/gradients_1/policy_1/Softmax_1_grad/SumSum1optimizer/gradients_1/policy_1/Softmax_1_grad/mulCoptimizer/gradients_1/policy_1/Softmax_1_grad/Sum/reduction_indices*
T0*

Tidx0*
	keep_dims(
�
1optimizer/gradients_1/policy_1/Softmax_1_grad/subSubWoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits/Reshape_1_grad/Reshape1optimizer/gradients_1/policy_1/Softmax_1_grad/Sum*
T0
�
3optimizer/gradients_1/policy_1/Softmax_1_grad/mul_1Mul1optimizer/gradients_1/policy_1/Softmax_1_grad/subpolicy_1/Softmax_1*
T0
b
0optimizer/gradients_1/optimizer/sub_1_grad/ShapeShapepolicy_1/Sum_2*
T0*
out_type0
e
2optimizer/gradients_1/optimizer/sub_1_grad/Shape_1Shapeoptimizer/Sum_1*
T0*
out_type0
�
@optimizer/gradients_1/optimizer/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgs0optimizer/gradients_1/optimizer/sub_1_grad/Shape2optimizer/gradients_1/optimizer/sub_1_grad/Shape_1*
T0
�
.optimizer/gradients_1/optimizer/sub_1_grad/SumSum,optimizer/gradients_1/optimizer/Exp_grad/mul@optimizer/gradients_1/optimizer/sub_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients_1/optimizer/sub_1_grad/ReshapeReshape.optimizer/gradients_1/optimizer/sub_1_grad/Sum0optimizer/gradients_1/optimizer/sub_1_grad/Shape*
T0*
Tshape0
l
.optimizer/gradients_1/optimizer/sub_1_grad/NegNeg,optimizer/gradients_1/optimizer/Exp_grad/mul*
T0
�
0optimizer/gradients_1/optimizer/sub_1_grad/Sum_1Sum.optimizer/gradients_1/optimizer/sub_1_grad/NegBoptimizer/gradients_1/optimizer/sub_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_1/optimizer/sub_1_grad/Reshape_1Reshape0optimizer/gradients_1/optimizer/sub_1_grad/Sum_12optimizer/gradients_1/optimizer/sub_1_grad/Shape_1*
T0*
Tshape0
�
;optimizer/gradients_1/optimizer/sub_1_grad/tuple/group_depsNoOp3^optimizer/gradients_1/optimizer/sub_1_grad/Reshape5^optimizer/gradients_1/optimizer/sub_1_grad/Reshape_1
�
Coptimizer/gradients_1/optimizer/sub_1_grad/tuple/control_dependencyIdentity2optimizer/gradients_1/optimizer/sub_1_grad/Reshape<^optimizer/gradients_1/optimizer/sub_1_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients_1/optimizer/sub_1_grad/Reshape
�
Eoptimizer/gradients_1/optimizer/sub_1_grad/tuple/control_dependency_1Identity4optimizer/gradients_1/optimizer/sub_1_grad/Reshape_1<^optimizer/gradients_1/optimizer/sub_1_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_1/optimizer/sub_1_grad/Reshape_1
{
8optimizer/gradients_1/optimizer/clip_by_value_grad/ShapeShapeoptimizer/clip_by_value/Minimum*
T0*
out_type0
c
:optimizer/gradients_1/optimizer/clip_by_value_grad/Shape_1Const*
dtype0*
valueB 
�
:optimizer/gradients_1/optimizer/clip_by_value_grad/Shape_2ShapeEoptimizer/gradients_1/optimizer/add_3_grad/tuple/control_dependency_1*
T0*
out_type0
k
>optimizer/gradients_1/optimizer/clip_by_value_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
8optimizer/gradients_1/optimizer/clip_by_value_grad/zerosFill:optimizer/gradients_1/optimizer/clip_by_value_grad/Shape_2>optimizer/gradients_1/optimizer/clip_by_value_grad/zeros/Const*
T0*

index_type0
�
?optimizer/gradients_1/optimizer/clip_by_value_grad/GreaterEqualGreaterEqualoptimizer/clip_by_value/Minimumoptimizer/Neg_1*
T0
�
Hoptimizer/gradients_1/optimizer/clip_by_value_grad/BroadcastGradientArgsBroadcastGradientArgs8optimizer/gradients_1/optimizer/clip_by_value_grad/Shape:optimizer/gradients_1/optimizer/clip_by_value_grad/Shape_1*
T0
�
;optimizer/gradients_1/optimizer/clip_by_value_grad/SelectV2SelectV2?optimizer/gradients_1/optimizer/clip_by_value_grad/GreaterEqualEoptimizer/gradients_1/optimizer/add_3_grad/tuple/control_dependency_18optimizer/gradients_1/optimizer/clip_by_value_grad/zeros*
T0
�
6optimizer/gradients_1/optimizer/clip_by_value_grad/SumSum;optimizer/gradients_1/optimizer/clip_by_value_grad/SelectV2Hoptimizer/gradients_1/optimizer/clip_by_value_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
:optimizer/gradients_1/optimizer/clip_by_value_grad/ReshapeReshape6optimizer/gradients_1/optimizer/clip_by_value_grad/Sum8optimizer/gradients_1/optimizer/clip_by_value_grad/Shape*
T0*
Tshape0
�
=optimizer/gradients_1/optimizer/clip_by_value_grad/SelectV2_1SelectV2?optimizer/gradients_1/optimizer/clip_by_value_grad/GreaterEqual8optimizer/gradients_1/optimizer/clip_by_value_grad/zerosEoptimizer/gradients_1/optimizer/add_3_grad/tuple/control_dependency_1*
T0
�
8optimizer/gradients_1/optimizer/clip_by_value_grad/Sum_1Sum=optimizer/gradients_1/optimizer/clip_by_value_grad/SelectV2_1Joptimizer/gradients_1/optimizer/clip_by_value_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
<optimizer/gradients_1/optimizer/clip_by_value_grad/Reshape_1Reshape8optimizer/gradients_1/optimizer/clip_by_value_grad/Sum_1:optimizer/gradients_1/optimizer/clip_by_value_grad/Shape_1*
T0*
Tshape0
�
Coptimizer/gradients_1/optimizer/clip_by_value_grad/tuple/group_depsNoOp;^optimizer/gradients_1/optimizer/clip_by_value_grad/Reshape=^optimizer/gradients_1/optimizer/clip_by_value_grad/Reshape_1
�
Koptimizer/gradients_1/optimizer/clip_by_value_grad/tuple/control_dependencyIdentity:optimizer/gradients_1/optimizer/clip_by_value_grad/ReshapeD^optimizer/gradients_1/optimizer/clip_by_value_grad/tuple/group_deps*
T0*M
_classC
A?loc:@optimizer/gradients_1/optimizer/clip_by_value_grad/Reshape
�
Moptimizer/gradients_1/optimizer/clip_by_value_grad/tuple/control_dependency_1Identity<optimizer/gradients_1/optimizer/clip_by_value_grad/Reshape_1D^optimizer/gradients_1/optimizer/clip_by_value_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_1/optimizer/clip_by_value_grad/Reshape_1
u
9optimizer/gradients_1/policy_1/strided_slice_2_grad/ShapeShapepolicy_1/concat_2/concat*
T0*
out_type0

Joptimizer/gradients_1/policy_1/strided_slice_2_grad/StridedSliceGrad/beginConst*
dtype0*
valueB"        
}
Hoptimizer/gradients_1/policy_1/strided_slice_2_grad/StridedSliceGrad/endConst*
dtype0*
valueB"       
�
Loptimizer/gradients_1/policy_1/strided_slice_2_grad/StridedSliceGrad/stridesConst*
dtype0*
valueB"      
�
Doptimizer/gradients_1/policy_1/strided_slice_2_grad/StridedSliceGradStridedSliceGrad9optimizer/gradients_1/policy_1/strided_slice_2_grad/ShapeJoptimizer/gradients_1/policy_1/strided_slice_2_grad/StridedSliceGrad/beginHoptimizer/gradients_1/policy_1/strided_slice_2_grad/StridedSliceGrad/endLoptimizer/gradients_1/policy_1/strided_slice_2_grad/StridedSliceGrad/strides3optimizer/gradients_1/policy_1/Softmax_1_grad/mul_1*
Index0*
T0*

begin_mask*
ellipsis_mask *
end_mask*
new_axis_mask *
shrink_axis_mask 
c
/optimizer/gradients_1/policy_1/Sum_2_grad/ShapeShapepolicy_1/stack_1*
T0*
out_type0
�
5optimizer/gradients_1/policy_1/Sum_2_grad/BroadcastToBroadcastToCoptimizer/gradients_1/optimizer/sub_1_grad/tuple/control_dependency/optimizer/gradients_1/policy_1/Sum_2_grad/Shape*
T0*

Tidx0
q
@optimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/ShapeShapeoptimizer/sub*
T0*
out_type0
k
Boptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/Shape_1Const*
dtype0*
valueB 
�
Boptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/Shape_2ShapeKoptimizer/gradients_1/optimizer/clip_by_value_grad/tuple/control_dependency*
T0*
out_type0
s
Foptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
@optimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/zerosFillBoptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/Shape_2Foptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/zeros/Const*
T0*

index_type0
�
Doptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/LessEqual	LessEqualoptimizer/suboptimizer/PolynomialDecay_1*
T0
�
Poptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs@optimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/ShapeBoptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/Shape_1*
T0
�
Coptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/SelectV2SelectV2Doptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/LessEqualKoptimizer/gradients_1/optimizer/clip_by_value_grad/tuple/control_dependency@optimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/zeros*
T0
�
>optimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/SumSumCoptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/SelectV2Poptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Boptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/ReshapeReshape>optimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/Sum@optimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/Shape*
T0*
Tshape0
�
Eoptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/SelectV2_1SelectV2Doptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/LessEqual@optimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/zerosKoptimizer/gradients_1/optimizer/clip_by_value_grad/tuple/control_dependency*
T0
�
@optimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/Sum_1SumEoptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/SelectV2_1Roptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Doptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/Reshape_1Reshape@optimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/Sum_1Boptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/Shape_1*
T0*
Tshape0
�
Koptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/tuple/group_depsNoOpC^optimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/ReshapeE^optimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/Reshape_1
�
Soptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/tuple/control_dependencyIdentityBoptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/ReshapeL^optimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/tuple/group_deps*
T0*U
_classK
IGloc:@optimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/Reshape
�
Uoptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/tuple/control_dependency_1IdentityDoptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/Reshape_1L^optimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/tuple/group_deps*
T0*W
_classM
KIloc:@optimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/Reshape_1
�
3optimizer/gradients_1/policy_1/stack_1_grad/unstackUnpack5optimizer/gradients_1/policy_1/Sum_2_grad/BroadcastTo*
T0*

axis*	
num
a
.optimizer/gradients_1/optimizer/sub_grad/ShapeShapeoptimizer/Sum_2*
T0*
out_type0
v
0optimizer/gradients_1/optimizer/sub_grad/Shape_1Shape"optimizer/extrinsic_value_estimate*
T0*
out_type0
�
>optimizer/gradients_1/optimizer/sub_grad/BroadcastGradientArgsBroadcastGradientArgs.optimizer/gradients_1/optimizer/sub_grad/Shape0optimizer/gradients_1/optimizer/sub_grad/Shape_1*
T0
�
,optimizer/gradients_1/optimizer/sub_grad/SumSumSoptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/tuple/control_dependency>optimizer/gradients_1/optimizer/sub_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
0optimizer/gradients_1/optimizer/sub_grad/ReshapeReshape,optimizer/gradients_1/optimizer/sub_grad/Sum.optimizer/gradients_1/optimizer/sub_grad/Shape*
T0*
Tshape0
�
,optimizer/gradients_1/optimizer/sub_grad/NegNegSoptimizer/gradients_1/optimizer/clip_by_value/Minimum_grad/tuple/control_dependency*
T0
�
.optimizer/gradients_1/optimizer/sub_grad/Sum_1Sum,optimizer/gradients_1/optimizer/sub_grad/Neg@optimizer/gradients_1/optimizer/sub_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients_1/optimizer/sub_grad/Reshape_1Reshape.optimizer/gradients_1/optimizer/sub_grad/Sum_10optimizer/gradients_1/optimizer/sub_grad/Shape_1*
T0*
Tshape0
�
9optimizer/gradients_1/optimizer/sub_grad/tuple/group_depsNoOp1^optimizer/gradients_1/optimizer/sub_grad/Reshape3^optimizer/gradients_1/optimizer/sub_grad/Reshape_1
�
Aoptimizer/gradients_1/optimizer/sub_grad/tuple/control_dependencyIdentity0optimizer/gradients_1/optimizer/sub_grad/Reshape:^optimizer/gradients_1/optimizer/sub_grad/tuple/group_deps*
T0*C
_class9
75loc:@optimizer/gradients_1/optimizer/sub_grad/Reshape
�
Coptimizer/gradients_1/optimizer/sub_grad/tuple/control_dependency_1Identity2optimizer/gradients_1/optimizer/sub_grad/Reshape_1:^optimizer/gradients_1/optimizer/sub_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients_1/optimizer/sub_grad/Reshape_1
p
+optimizer/gradients_1/policy_1/Neg_grad/NegNeg3optimizer/gradients_1/policy_1/stack_1_grad/unstack*
T0
u
0optimizer/gradients_1/optimizer/Sum_2_grad/ShapeShape!optimizer/extrinsic_value/BiasAdd*
T0*
out_type0
�
/optimizer/gradients_1/optimizer/Sum_2_grad/SizeConst*C
_class9
75loc:@optimizer/gradients_1/optimizer/Sum_2_grad/Shape*
dtype0*
value	B :
�
.optimizer/gradients_1/optimizer/Sum_2_grad/addAddV2!optimizer/Sum_2/reduction_indices/optimizer/gradients_1/optimizer/Sum_2_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_1/optimizer/Sum_2_grad/Shape
�
.optimizer/gradients_1/optimizer/Sum_2_grad/modFloorMod.optimizer/gradients_1/optimizer/Sum_2_grad/add/optimizer/gradients_1/optimizer/Sum_2_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_1/optimizer/Sum_2_grad/Shape
�
2optimizer/gradients_1/optimizer/Sum_2_grad/Shape_1Const*C
_class9
75loc:@optimizer/gradients_1/optimizer/Sum_2_grad/Shape*
dtype0*
valueB 
�
6optimizer/gradients_1/optimizer/Sum_2_grad/range/startConst*C
_class9
75loc:@optimizer/gradients_1/optimizer/Sum_2_grad/Shape*
dtype0*
value	B : 
�
6optimizer/gradients_1/optimizer/Sum_2_grad/range/deltaConst*C
_class9
75loc:@optimizer/gradients_1/optimizer/Sum_2_grad/Shape*
dtype0*
value	B :
�
0optimizer/gradients_1/optimizer/Sum_2_grad/rangeRange6optimizer/gradients_1/optimizer/Sum_2_grad/range/start/optimizer/gradients_1/optimizer/Sum_2_grad/Size6optimizer/gradients_1/optimizer/Sum_2_grad/range/delta*

Tidx0*C
_class9
75loc:@optimizer/gradients_1/optimizer/Sum_2_grad/Shape
�
5optimizer/gradients_1/optimizer/Sum_2_grad/Fill/valueConst*C
_class9
75loc:@optimizer/gradients_1/optimizer/Sum_2_grad/Shape*
dtype0*
value	B :
�
/optimizer/gradients_1/optimizer/Sum_2_grad/FillFill2optimizer/gradients_1/optimizer/Sum_2_grad/Shape_15optimizer/gradients_1/optimizer/Sum_2_grad/Fill/value*
T0*C
_class9
75loc:@optimizer/gradients_1/optimizer/Sum_2_grad/Shape*

index_type0
�
8optimizer/gradients_1/optimizer/Sum_2_grad/DynamicStitchDynamicStitch0optimizer/gradients_1/optimizer/Sum_2_grad/range.optimizer/gradients_1/optimizer/Sum_2_grad/mod0optimizer/gradients_1/optimizer/Sum_2_grad/Shape/optimizer/gradients_1/optimizer/Sum_2_grad/Fill*
N*
T0*C
_class9
75loc:@optimizer/gradients_1/optimizer/Sum_2_grad/Shape
�
2optimizer/gradients_1/optimizer/Sum_2_grad/ReshapeReshapeAoptimizer/gradients_1/optimizer/sub_grad/tuple/control_dependency8optimizer/gradients_1/optimizer/Sum_2_grad/DynamicStitch*
T0*
Tshape0
�
6optimizer/gradients_1/optimizer/Sum_2_grad/BroadcastToBroadcastTo2optimizer/gradients_1/optimizer/Sum_2_grad/Reshape0optimizer/gradients_1/optimizer/Sum_2_grad/Shape*
T0*

Tidx0
�
Woptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1/Reshape_2_grad/ShapeShape,policy_1/softmax_cross_entropy_with_logits_1*
T0*
out_type0
�
Yoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1/Reshape_2_grad/ReshapeReshape+optimizer/gradients_1/policy_1/Neg_grad/NegWoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1/Reshape_2_grad/Shape*
T0*
Tshape0
�
optimizer/gradients_1/AddN_1AddN6optimizer/gradients_1/optimizer/Sum_3_grad/BroadcastTo6optimizer/gradients_1/optimizer/Sum_2_grad/BroadcastTo*
N*
T0*I
_class?
=;loc:@optimizer/gradients_1/optimizer/Sum_3_grad/BroadcastTo
�
Hoptimizer/gradients_1/optimizer/extrinsic_value/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_1/AddN_1*
T0*
data_formatNHWC
�
Moptimizer/gradients_1/optimizer/extrinsic_value/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_1/AddN_1I^optimizer/gradients_1/optimizer/extrinsic_value/BiasAdd_grad/BiasAddGrad
�
Uoptimizer/gradients_1/optimizer/extrinsic_value/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_1/AddN_1N^optimizer/gradients_1/optimizer/extrinsic_value/BiasAdd_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients_1/optimizer/Sum_3_grad/BroadcastTo
�
Woptimizer/gradients_1/optimizer/extrinsic_value/BiasAdd_grad/tuple/control_dependency_1IdentityHoptimizer/gradients_1/optimizer/extrinsic_value/BiasAdd_grad/BiasAddGradN^optimizer/gradients_1/optimizer/extrinsic_value/BiasAdd_grad/tuple/group_deps*
T0*[
_classQ
OMloc:@optimizer/gradients_1/optimizer/extrinsic_value/BiasAdd_grad/BiasAddGrad
h
"optimizer/gradients_1/zeros_like_4	ZerosLike.policy_1/softmax_cross_entropy_with_logits_1:1*
T0
�
Voptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/ExpandDims/dimConst*
dtype0*
valueB :
���������
�
Roptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/ExpandDims
ExpandDimsYoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1/Reshape_2_grad/ReshapeVoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/ExpandDims/dim*
T0*

Tdim0
�
Koptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/mulMulRoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/ExpandDims.policy_1/softmax_cross_entropy_with_logits_1:1*
T0
�
Roptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/LogSoftmax
LogSoftmax4policy_1/softmax_cross_entropy_with_logits_1/Reshape*
T0
�
Koptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/NegNegRoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/LogSoftmax*
T0
�
Xoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/ExpandDims_1/dimConst*
dtype0*
valueB :
���������
�
Toptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/ExpandDims_1
ExpandDimsYoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1/Reshape_2_grad/ReshapeXoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/ExpandDims_1/dim*
T0*

Tdim0
�
Moptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/mul_1MulToptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/ExpandDims_1Koptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/Neg*
T0
�
Xoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/tuple/group_depsNoOpL^optimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/mulN^optimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/mul_1
�
`optimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/tuple/control_dependencyIdentityKoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/mulY^optimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/tuple/group_deps*
T0*^
_classT
RPloc:@optimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/mul
�
boptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/tuple/control_dependency_1IdentityMoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/mul_1Y^optimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/tuple/group_deps*
T0*`
_classV
TRloc:@optimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/mul_1
�
Boptimizer/gradients_1/optimizer/extrinsic_value/MatMul_grad/MatMulMatMulUoptimizer/gradients_1/optimizer/extrinsic_value/BiasAdd_grad/tuple/control_dependency&optimizer//extrinsic_value/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Doptimizer/gradients_1/optimizer/extrinsic_value/MatMul_grad/MatMul_1MatMul#optimizer/main_graph_0/hidden_1/MulUoptimizer/gradients_1/optimizer/extrinsic_value/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Loptimizer/gradients_1/optimizer/extrinsic_value/MatMul_grad/tuple/group_depsNoOpC^optimizer/gradients_1/optimizer/extrinsic_value/MatMul_grad/MatMulE^optimizer/gradients_1/optimizer/extrinsic_value/MatMul_grad/MatMul_1
�
Toptimizer/gradients_1/optimizer/extrinsic_value/MatMul_grad/tuple/control_dependencyIdentityBoptimizer/gradients_1/optimizer/extrinsic_value/MatMul_grad/MatMulM^optimizer/gradients_1/optimizer/extrinsic_value/MatMul_grad/tuple/group_deps*
T0*U
_classK
IGloc:@optimizer/gradients_1/optimizer/extrinsic_value/MatMul_grad/MatMul
�
Voptimizer/gradients_1/optimizer/extrinsic_value/MatMul_grad/tuple/control_dependency_1IdentityDoptimizer/gradients_1/optimizer/extrinsic_value/MatMul_grad/MatMul_1M^optimizer/gradients_1/optimizer/extrinsic_value/MatMul_grad/tuple/group_deps*
T0*W
_classM
KIloc:@optimizer/gradients_1/optimizer/extrinsic_value/MatMul_grad/MatMul_1
�
Uoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1/Reshape_grad/ShapeShapepolicy_1/strided_slice_5*
T0*
out_type0
�
Woptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1/Reshape_grad/ReshapeReshape`optimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1_grad/tuple/control_dependencyUoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1/Reshape_grad/Shape*
T0*
Tshape0
�
Doptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/ShapeShape'optimizer/main_graph_0/hidden_1/BiasAdd*
T0*
out_type0
�
Foptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/Shape_1Shape'optimizer/main_graph_0/hidden_1/Sigmoid*
T0*
out_type0
�
Toptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsDoptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/ShapeFoptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/Shape_1*
T0
�
Boptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/MulMulToptimizer/gradients_1/optimizer/extrinsic_value/MatMul_grad/tuple/control_dependency'optimizer/main_graph_0/hidden_1/Sigmoid*
T0
�
Boptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/SumSumBoptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/MulToptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Foptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/ReshapeReshapeBoptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/SumDoptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/Shape*
T0*
Tshape0
�
Doptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/Mul_1Mul'optimizer/main_graph_0/hidden_1/BiasAddToptimizer/gradients_1/optimizer/extrinsic_value/MatMul_grad/tuple/control_dependency*
T0
�
Doptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/Sum_1SumDoptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/Mul_1Voptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Hoptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape_1ReshapeDoptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/Sum_1Foptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/Shape_1*
T0*
Tshape0
�
Ooptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/group_depsNoOpG^optimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/ReshapeI^optimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape_1
�
Woptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/control_dependencyIdentityFoptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/ReshapeP^optimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape
�
Yoptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency_1IdentityHoptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape_1P^optimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/group_deps*
T0*[
_classQ
OMloc:@optimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape_1
u
9optimizer/gradients_1/policy_1/strided_slice_5_grad/ShapeShapepolicy_1/concat_2/concat*
T0*
out_type0

Joptimizer/gradients_1/policy_1/strided_slice_5_grad/StridedSliceGrad/beginConst*
dtype0*
valueB"        
}
Hoptimizer/gradients_1/policy_1/strided_slice_5_grad/StridedSliceGrad/endConst*
dtype0*
valueB"       
�
Loptimizer/gradients_1/policy_1/strided_slice_5_grad/StridedSliceGrad/stridesConst*
dtype0*
valueB"      
�
Doptimizer/gradients_1/policy_1/strided_slice_5_grad/StridedSliceGradStridedSliceGrad9optimizer/gradients_1/policy_1/strided_slice_5_grad/ShapeJoptimizer/gradients_1/policy_1/strided_slice_5_grad/StridedSliceGrad/beginHoptimizer/gradients_1/policy_1/strided_slice_5_grad/StridedSliceGrad/endLoptimizer/gradients_1/policy_1/strided_slice_5_grad/StridedSliceGrad/stridesWoptimizer/gradients_1/policy_1/softmax_cross_entropy_with_logits_1/Reshape_grad/Reshape*
Index0*
T0*

begin_mask*
ellipsis_mask *
end_mask*
new_axis_mask *
shrink_axis_mask 
�
Noptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Sigmoid_grad/SigmoidGradSigmoidGrad'optimizer/main_graph_0/hidden_1/SigmoidYoptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency_1*
T0
�
optimizer/gradients_1/AddN_2AddNDoptimizer/gradients_1/policy_1/strided_slice_3_grad/StridedSliceGradDoptimizer/gradients_1/policy_1/strided_slice_2_grad/StridedSliceGradDoptimizer/gradients_1/policy_1/strided_slice_5_grad/StridedSliceGrad*
N*
T0*W
_classM
KIloc:@optimizer/gradients_1/policy_1/strided_slice_3_grad/StridedSliceGrad
�
optimizer/gradients_1/AddN_3AddNWoptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/control_dependencyNoptimizer/gradients_1/optimizer/main_graph_0/hidden_1/Sigmoid_grad/SigmoidGrad*
N*
T0*Y
_classO
MKloc:@optimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape
�
Noptimizer/gradients_1/optimizer/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_1/AddN_3*
T0*
data_formatNHWC
�
Soptimizer/gradients_1/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_1/AddN_3O^optimizer/gradients_1/optimizer/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad
�
[optimizer/gradients_1/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_1/AddN_3T^optimizer/gradients_1/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients_1/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape
�
]optimizer/gradients_1/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency_1IdentityNoptimizer/gradients_1/optimizer/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGradT^optimizer/gradients_1/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*a
_classW
USloc:@optimizer/gradients_1/optimizer/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad
z
4optimizer/gradients_1/policy_1/Log_1_grad/Reciprocal
Reciprocalpolicy_1/add_2^optimizer/gradients_1/AddN_2*
T0
�
-optimizer/gradients_1/policy_1/Log_1_grad/mulMuloptimizer/gradients_1/AddN_24optimizer/gradients_1/policy_1/Log_1_grad/Reciprocal*
T0
�
Hoptimizer/gradients_1/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMulMatMul[optimizer/gradients_1/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency,optimizer//main_graph_0/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Joptimizer/gradients_1/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMul_1MatMul#optimizer/main_graph_0/hidden_0/Mul[optimizer/gradients_1/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Roptimizer/gradients_1/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/group_depsNoOpI^optimizer/gradients_1/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMulK^optimizer/gradients_1/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMul_1
�
Zoptimizer/gradients_1/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependencyIdentityHoptimizer/gradients_1/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMulS^optimizer/gradients_1/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/group_deps*
T0*[
_classQ
OMloc:@optimizer/gradients_1/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMul
�
\optimizer/gradients_1/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency_1IdentityJoptimizer/gradients_1/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMul_1S^optimizer/gradients_1/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/group_deps*
T0*]
_classS
QOloc:@optimizer/gradients_1/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMul_1
c
/optimizer/gradients_1/policy_1/add_2_grad/ShapeShapepolicy_1/truediv*
T0*
out_type0
e
1optimizer/gradients_1/policy_1/add_2_grad/Shape_1Shapepolicy_1/add_2/y*
T0*
out_type0
�
?optimizer/gradients_1/policy_1/add_2_grad/BroadcastGradientArgsBroadcastGradientArgs/optimizer/gradients_1/policy_1/add_2_grad/Shape1optimizer/gradients_1/policy_1/add_2_grad/Shape_1*
T0
�
-optimizer/gradients_1/policy_1/add_2_grad/SumSum-optimizer/gradients_1/policy_1/Log_1_grad/mul?optimizer/gradients_1/policy_1/add_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
1optimizer/gradients_1/policy_1/add_2_grad/ReshapeReshape-optimizer/gradients_1/policy_1/add_2_grad/Sum/optimizer/gradients_1/policy_1/add_2_grad/Shape*
T0*
Tshape0
�
/optimizer/gradients_1/policy_1/add_2_grad/Sum_1Sum-optimizer/gradients_1/policy_1/Log_1_grad/mulAoptimizer/gradients_1/policy_1/add_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_1/policy_1/add_2_grad/Reshape_1Reshape/optimizer/gradients_1/policy_1/add_2_grad/Sum_11optimizer/gradients_1/policy_1/add_2_grad/Shape_1*
T0*
Tshape0
�
:optimizer/gradients_1/policy_1/add_2_grad/tuple/group_depsNoOp2^optimizer/gradients_1/policy_1/add_2_grad/Reshape4^optimizer/gradients_1/policy_1/add_2_grad/Reshape_1
�
Boptimizer/gradients_1/policy_1/add_2_grad/tuple/control_dependencyIdentity1optimizer/gradients_1/policy_1/add_2_grad/Reshape;^optimizer/gradients_1/policy_1/add_2_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_1/policy_1/add_2_grad/Reshape
�
Doptimizer/gradients_1/policy_1/add_2_grad/tuple/control_dependency_1Identity3optimizer/gradients_1/policy_1/add_2_grad/Reshape_1;^optimizer/gradients_1/policy_1/add_2_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_1/policy_1/add_2_grad/Reshape_1
�
Doptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/ShapeShape'optimizer/main_graph_0/hidden_0/BiasAdd*
T0*
out_type0
�
Foptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/Shape_1Shape'optimizer/main_graph_0/hidden_0/Sigmoid*
T0*
out_type0
�
Toptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsDoptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/ShapeFoptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/Shape_1*
T0
�
Boptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/MulMulZoptimizer/gradients_1/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency'optimizer/main_graph_0/hidden_0/Sigmoid*
T0
�
Boptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/SumSumBoptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/MulToptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Foptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/ReshapeReshapeBoptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/SumDoptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/Shape*
T0*
Tshape0
�
Doptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/Mul_1Mul'optimizer/main_graph_0/hidden_0/BiasAddZoptimizer/gradients_1/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency*
T0
�
Doptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/Sum_1SumDoptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/Mul_1Voptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Hoptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape_1ReshapeDoptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/Sum_1Foptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/Shape_1*
T0*
Tshape0
�
Ooptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/group_depsNoOpG^optimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/ReshapeI^optimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape_1
�
Woptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/control_dependencyIdentityFoptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/ReshapeP^optimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape
�
Yoptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency_1IdentityHoptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape_1P^optimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/group_deps*
T0*[
_classQ
OMloc:@optimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape_1
a
1optimizer/gradients_1/policy_1/truediv_grad/ShapeShapepolicy_1/Mul*
T0*
out_type0
c
3optimizer/gradients_1/policy_1/truediv_grad/Shape_1Shapepolicy_1/Sum*
T0*
out_type0
�
Aoptimizer/gradients_1/policy_1/truediv_grad/BroadcastGradientArgsBroadcastGradientArgs1optimizer/gradients_1/policy_1/truediv_grad/Shape3optimizer/gradients_1/policy_1/truediv_grad/Shape_1*
T0
�
3optimizer/gradients_1/policy_1/truediv_grad/RealDivRealDivBoptimizer/gradients_1/policy_1/add_2_grad/tuple/control_dependencypolicy_1/Sum*
T0
�
/optimizer/gradients_1/policy_1/truediv_grad/SumSum3optimizer/gradients_1/policy_1/truediv_grad/RealDivAoptimizer/gradients_1/policy_1/truediv_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_1/policy_1/truediv_grad/ReshapeReshape/optimizer/gradients_1/policy_1/truediv_grad/Sum1optimizer/gradients_1/policy_1/truediv_grad/Shape*
T0*
Tshape0
M
/optimizer/gradients_1/policy_1/truediv_grad/NegNegpolicy_1/Mul*
T0
�
5optimizer/gradients_1/policy_1/truediv_grad/RealDiv_1RealDiv/optimizer/gradients_1/policy_1/truediv_grad/Negpolicy_1/Sum*
T0
�
5optimizer/gradients_1/policy_1/truediv_grad/RealDiv_2RealDiv5optimizer/gradients_1/policy_1/truediv_grad/RealDiv_1policy_1/Sum*
T0
�
/optimizer/gradients_1/policy_1/truediv_grad/mulMulBoptimizer/gradients_1/policy_1/add_2_grad/tuple/control_dependency5optimizer/gradients_1/policy_1/truediv_grad/RealDiv_2*
T0
�
1optimizer/gradients_1/policy_1/truediv_grad/Sum_1Sum/optimizer/gradients_1/policy_1/truediv_grad/mulCoptimizer/gradients_1/policy_1/truediv_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
5optimizer/gradients_1/policy_1/truediv_grad/Reshape_1Reshape1optimizer/gradients_1/policy_1/truediv_grad/Sum_13optimizer/gradients_1/policy_1/truediv_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_1/policy_1/truediv_grad/tuple/group_depsNoOp4^optimizer/gradients_1/policy_1/truediv_grad/Reshape6^optimizer/gradients_1/policy_1/truediv_grad/Reshape_1
�
Doptimizer/gradients_1/policy_1/truediv_grad/tuple/control_dependencyIdentity3optimizer/gradients_1/policy_1/truediv_grad/Reshape=^optimizer/gradients_1/policy_1/truediv_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_1/policy_1/truediv_grad/Reshape
�
Foptimizer/gradients_1/policy_1/truediv_grad/tuple/control_dependency_1Identity5optimizer/gradients_1/policy_1/truediv_grad/Reshape_1=^optimizer/gradients_1/policy_1/truediv_grad/tuple/group_deps*
T0*H
_class>
<:loc:@optimizer/gradients_1/policy_1/truediv_grad/Reshape_1
�
Noptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Sigmoid_grad/SigmoidGradSigmoidGrad'optimizer/main_graph_0/hidden_0/SigmoidYoptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency_1*
T0
]
-optimizer/gradients_1/policy_1/Sum_grad/ShapeShapepolicy_1/Mul*
T0*
out_type0
�
3optimizer/gradients_1/policy_1/Sum_grad/BroadcastToBroadcastToFoptimizer/gradients_1/policy_1/truediv_grad/tuple/control_dependency_1-optimizer/gradients_1/policy_1/Sum_grad/Shape*
T0*

Tidx0
�
optimizer/gradients_1/AddN_4AddNWoptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/control_dependencyNoptimizer/gradients_1/optimizer/main_graph_0/hidden_0/Sigmoid_grad/SigmoidGrad*
N*
T0*Y
_classO
MKloc:@optimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape
�
Noptimizer/gradients_1/optimizer/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_1/AddN_4*
T0*
data_formatNHWC
�
Soptimizer/gradients_1/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_1/AddN_4O^optimizer/gradients_1/optimizer/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad
�
[optimizer/gradients_1/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_1/AddN_4T^optimizer/gradients_1/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients_1/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape
�
]optimizer/gradients_1/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency_1IdentityNoptimizer/gradients_1/optimizer/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGradT^optimizer/gradients_1/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*a
_classW
USloc:@optimizer/gradients_1/optimizer/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad
�
optimizer/gradients_1/AddN_5AddNDoptimizer/gradients_1/policy_1/truediv_grad/tuple/control_dependency3optimizer/gradients_1/policy_1/Sum_grad/BroadcastTo*
N*
T0*F
_class<
:8loc:@optimizer/gradients_1/policy_1/truediv_grad/Reshape
]
-optimizer/gradients_1/policy_1/Mul_grad/ShapeShapepolicy_1/add*
T0*
out_type0
i
/optimizer/gradients_1/policy_1/Mul_grad/Shape_1Shapepolicy_1/strided_slice*
T0*
out_type0
�
=optimizer/gradients_1/policy_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgs-optimizer/gradients_1/policy_1/Mul_grad/Shape/optimizer/gradients_1/policy_1/Mul_grad/Shape_1*
T0
q
+optimizer/gradients_1/policy_1/Mul_grad/MulMuloptimizer/gradients_1/AddN_5policy_1/strided_slice*
T0
�
+optimizer/gradients_1/policy_1/Mul_grad/SumSum+optimizer/gradients_1/policy_1/Mul_grad/Mul=optimizer/gradients_1/policy_1/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
/optimizer/gradients_1/policy_1/Mul_grad/ReshapeReshape+optimizer/gradients_1/policy_1/Mul_grad/Sum-optimizer/gradients_1/policy_1/Mul_grad/Shape*
T0*
Tshape0
i
-optimizer/gradients_1/policy_1/Mul_grad/Mul_1Mulpolicy_1/addoptimizer/gradients_1/AddN_5*
T0
�
-optimizer/gradients_1/policy_1/Mul_grad/Sum_1Sum-optimizer/gradients_1/policy_1/Mul_grad/Mul_1?optimizer/gradients_1/policy_1/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
1optimizer/gradients_1/policy_1/Mul_grad/Reshape_1Reshape-optimizer/gradients_1/policy_1/Mul_grad/Sum_1/optimizer/gradients_1/policy_1/Mul_grad/Shape_1*
T0*
Tshape0
�
8optimizer/gradients_1/policy_1/Mul_grad/tuple/group_depsNoOp0^optimizer/gradients_1/policy_1/Mul_grad/Reshape2^optimizer/gradients_1/policy_1/Mul_grad/Reshape_1
�
@optimizer/gradients_1/policy_1/Mul_grad/tuple/control_dependencyIdentity/optimizer/gradients_1/policy_1/Mul_grad/Reshape9^optimizer/gradients_1/policy_1/Mul_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients_1/policy_1/Mul_grad/Reshape
�
Boptimizer/gradients_1/policy_1/Mul_grad/tuple/control_dependency_1Identity1optimizer/gradients_1/policy_1/Mul_grad/Reshape_19^optimizer/gradients_1/policy_1/Mul_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_1/policy_1/Mul_grad/Reshape_1
�
Hoptimizer/gradients_1/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMulMatMul[optimizer/gradients_1/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency,optimizer//main_graph_0/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Joptimizer/gradients_1/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMul_1MatMulnormalized_state[optimizer/gradients_1/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Roptimizer/gradients_1/optimizer/main_graph_0/hidden_0/MatMul_grad/tuple/group_depsNoOpI^optimizer/gradients_1/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMulK^optimizer/gradients_1/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMul_1
�
Zoptimizer/gradients_1/optimizer/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependencyIdentityHoptimizer/gradients_1/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMulS^optimizer/gradients_1/optimizer/main_graph_0/hidden_0/MatMul_grad/tuple/group_deps*
T0*[
_classQ
OMloc:@optimizer/gradients_1/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMul
�
\optimizer/gradients_1/optimizer/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependency_1IdentityJoptimizer/gradients_1/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMul_1S^optimizer/gradients_1/optimizer/main_graph_0/hidden_0/MatMul_grad/tuple/group_deps*
T0*]
_classS
QOloc:@optimizer/gradients_1/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMul_1
a
-optimizer/gradients_1/policy_1/add_grad/ShapeShapepolicy_1/Softmax*
T0*
out_type0
a
/optimizer/gradients_1/policy_1/add_grad/Shape_1Shapepolicy_1/add/y*
T0*
out_type0
�
=optimizer/gradients_1/policy_1/add_grad/BroadcastGradientArgsBroadcastGradientArgs-optimizer/gradients_1/policy_1/add_grad/Shape/optimizer/gradients_1/policy_1/add_grad/Shape_1*
T0
�
+optimizer/gradients_1/policy_1/add_grad/SumSum@optimizer/gradients_1/policy_1/Mul_grad/tuple/control_dependency=optimizer/gradients_1/policy_1/add_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
/optimizer/gradients_1/policy_1/add_grad/ReshapeReshape+optimizer/gradients_1/policy_1/add_grad/Sum-optimizer/gradients_1/policy_1/add_grad/Shape*
T0*
Tshape0
�
-optimizer/gradients_1/policy_1/add_grad/Sum_1Sum@optimizer/gradients_1/policy_1/Mul_grad/tuple/control_dependency?optimizer/gradients_1/policy_1/add_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
1optimizer/gradients_1/policy_1/add_grad/Reshape_1Reshape-optimizer/gradients_1/policy_1/add_grad/Sum_1/optimizer/gradients_1/policy_1/add_grad/Shape_1*
T0*
Tshape0
�
8optimizer/gradients_1/policy_1/add_grad/tuple/group_depsNoOp0^optimizer/gradients_1/policy_1/add_grad/Reshape2^optimizer/gradients_1/policy_1/add_grad/Reshape_1
�
@optimizer/gradients_1/policy_1/add_grad/tuple/control_dependencyIdentity/optimizer/gradients_1/policy_1/add_grad/Reshape9^optimizer/gradients_1/policy_1/add_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients_1/policy_1/add_grad/Reshape
�
Boptimizer/gradients_1/policy_1/add_grad/tuple/control_dependency_1Identity1optimizer/gradients_1/policy_1/add_grad/Reshape_19^optimizer/gradients_1/policy_1/add_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_1/policy_1/add_grad/Reshape_1
�
/optimizer/gradients_1/policy_1/Softmax_grad/mulMul@optimizer/gradients_1/policy_1/add_grad/tuple/control_dependencypolicy_1/Softmax*
T0
t
Aoptimizer/gradients_1/policy_1/Softmax_grad/Sum/reduction_indicesConst*
dtype0*
valueB :
���������
�
/optimizer/gradients_1/policy_1/Softmax_grad/SumSum/optimizer/gradients_1/policy_1/Softmax_grad/mulAoptimizer/gradients_1/policy_1/Softmax_grad/Sum/reduction_indices*
T0*

Tidx0*
	keep_dims(
�
/optimizer/gradients_1/policy_1/Softmax_grad/subSub@optimizer/gradients_1/policy_1/add_grad/tuple/control_dependency/optimizer/gradients_1/policy_1/Softmax_grad/Sum*
T0
�
1optimizer/gradients_1/policy_1/Softmax_grad/mul_1Mul/optimizer/gradients_1/policy_1/Softmax_grad/subpolicy_1/Softmax*
T0
�
7optimizer/gradients_1/policy_1/dense/MatMul_grad/MatMulMatMul1optimizer/gradients_1/policy_1/Softmax_grad/mul_1policy/dense/kernel/read*
T0*
transpose_a( *
transpose_b(
�
9optimizer/gradients_1/policy_1/dense/MatMul_grad/MatMul_1MatMul policy/main_graph_0/hidden_1/Mul1optimizer/gradients_1/policy_1/Softmax_grad/mul_1*
T0*
transpose_a(*
transpose_b( 
�
Aoptimizer/gradients_1/policy_1/dense/MatMul_grad/tuple/group_depsNoOp8^optimizer/gradients_1/policy_1/dense/MatMul_grad/MatMul:^optimizer/gradients_1/policy_1/dense/MatMul_grad/MatMul_1
�
Ioptimizer/gradients_1/policy_1/dense/MatMul_grad/tuple/control_dependencyIdentity7optimizer/gradients_1/policy_1/dense/MatMul_grad/MatMulB^optimizer/gradients_1/policy_1/dense/MatMul_grad/tuple/group_deps*
T0*J
_class@
><loc:@optimizer/gradients_1/policy_1/dense/MatMul_grad/MatMul
�
Koptimizer/gradients_1/policy_1/dense/MatMul_grad/tuple/control_dependency_1Identity9optimizer/gradients_1/policy_1/dense/MatMul_grad/MatMul_1B^optimizer/gradients_1/policy_1/dense/MatMul_grad/tuple/group_deps*
T0*L
_classB
@>loc:@optimizer/gradients_1/policy_1/dense/MatMul_grad/MatMul_1
�
Aoptimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/ShapeShape$policy/main_graph_0/hidden_1/BiasAdd*
T0*
out_type0
�
Coptimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/Shape_1Shape$policy/main_graph_0/hidden_1/Sigmoid*
T0*
out_type0
�
Qoptimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsAoptimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/ShapeCoptimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/Shape_1*
T0
�
?optimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/MulMulIoptimizer/gradients_1/policy_1/dense/MatMul_grad/tuple/control_dependency$policy/main_graph_0/hidden_1/Sigmoid*
T0
�
?optimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/SumSum?optimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/MulQoptimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Coptimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/ReshapeReshape?optimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/SumAoptimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/Shape*
T0*
Tshape0
�
Aoptimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/Mul_1Mul$policy/main_graph_0/hidden_1/BiasAddIoptimizer/gradients_1/policy_1/dense/MatMul_grad/tuple/control_dependency*
T0
�
Aoptimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/Sum_1SumAoptimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/Mul_1Soptimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Eoptimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1ReshapeAoptimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/Sum_1Coptimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/Shape_1*
T0*
Tshape0
�
Loptimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/tuple/group_depsNoOpD^optimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/ReshapeF^optimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1
�
Toptimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependencyIdentityCoptimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/ReshapeM^optimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/Reshape
�
Voptimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency_1IdentityEoptimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1M^optimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@optimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1
�
Koptimizer/gradients_1/policy/main_graph_0/hidden_1/Sigmoid_grad/SigmoidGradSigmoidGrad$policy/main_graph_0/hidden_1/SigmoidVoptimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency_1*
T0
�
optimizer/gradients_1/AddN_6AddNToptimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependencyKoptimizer/gradients_1/policy/main_graph_0/hidden_1/Sigmoid_grad/SigmoidGrad*
N*
T0*V
_classL
JHloc:@optimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/Reshape
�
Koptimizer/gradients_1/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_1/AddN_6*
T0*
data_formatNHWC
�
Poptimizer/gradients_1/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_1/AddN_6L^optimizer/gradients_1/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad
�
Xoptimizer/gradients_1/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_1/AddN_6Q^optimizer/gradients_1/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients_1/policy/main_graph_0/hidden_1/Mul_grad/Reshape
�
Zoptimizer/gradients_1/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency_1IdentityKoptimizer/gradients_1/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGradQ^optimizer/gradients_1/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*^
_classT
RPloc:@optimizer/gradients_1/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad
�
Eoptimizer/gradients_1/policy/main_graph_0/hidden_1/MatMul_grad/MatMulMatMulXoptimizer/gradients_1/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency(policy/main_graph_0/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Goptimizer/gradients_1/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1MatMul policy/main_graph_0/hidden_0/MulXoptimizer/gradients_1/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Ooptimizer/gradients_1/policy/main_graph_0/hidden_1/MatMul_grad/tuple/group_depsNoOpF^optimizer/gradients_1/policy/main_graph_0/hidden_1/MatMul_grad/MatMulH^optimizer/gradients_1/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1
�
Woptimizer/gradients_1/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependencyIdentityEoptimizer/gradients_1/policy/main_graph_0/hidden_1/MatMul_grad/MatMulP^optimizer/gradients_1/policy/main_graph_0/hidden_1/MatMul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@optimizer/gradients_1/policy/main_graph_0/hidden_1/MatMul_grad/MatMul
�
Yoptimizer/gradients_1/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency_1IdentityGoptimizer/gradients_1/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1P^optimizer/gradients_1/policy/main_graph_0/hidden_1/MatMul_grad/tuple/group_deps*
T0*Z
_classP
NLloc:@optimizer/gradients_1/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1
�
Aoptimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/ShapeShape$policy/main_graph_0/hidden_0/BiasAdd*
T0*
out_type0
�
Coptimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/Shape_1Shape$policy/main_graph_0/hidden_0/Sigmoid*
T0*
out_type0
�
Qoptimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsAoptimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/ShapeCoptimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/Shape_1*
T0
�
?optimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/MulMulWoptimizer/gradients_1/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency$policy/main_graph_0/hidden_0/Sigmoid*
T0
�
?optimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/SumSum?optimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/MulQoptimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Coptimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/ReshapeReshape?optimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/SumAoptimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/Shape*
T0*
Tshape0
�
Aoptimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/Mul_1Mul$policy/main_graph_0/hidden_0/BiasAddWoptimizer/gradients_1/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency*
T0
�
Aoptimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/Sum_1SumAoptimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/Mul_1Soptimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Eoptimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1ReshapeAoptimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/Sum_1Coptimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/Shape_1*
T0*
Tshape0
�
Loptimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/tuple/group_depsNoOpD^optimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/ReshapeF^optimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1
�
Toptimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependencyIdentityCoptimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/ReshapeM^optimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/Reshape
�
Voptimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency_1IdentityEoptimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1M^optimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@optimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1
�
Koptimizer/gradients_1/policy/main_graph_0/hidden_0/Sigmoid_grad/SigmoidGradSigmoidGrad$policy/main_graph_0/hidden_0/SigmoidVoptimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency_1*
T0
�
optimizer/gradients_1/AddN_7AddNToptimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependencyKoptimizer/gradients_1/policy/main_graph_0/hidden_0/Sigmoid_grad/SigmoidGrad*
N*
T0*V
_classL
JHloc:@optimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/Reshape
�
Koptimizer/gradients_1/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_1/AddN_7*
T0*
data_formatNHWC
�
Poptimizer/gradients_1/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_1/AddN_7L^optimizer/gradients_1/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad
�
Xoptimizer/gradients_1/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_1/AddN_7Q^optimizer/gradients_1/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients_1/policy/main_graph_0/hidden_0/Mul_grad/Reshape
�
Zoptimizer/gradients_1/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency_1IdentityKoptimizer/gradients_1/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGradQ^optimizer/gradients_1/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*^
_classT
RPloc:@optimizer/gradients_1/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad
�
Eoptimizer/gradients_1/policy/main_graph_0/hidden_0/MatMul_grad/MatMulMatMulXoptimizer/gradients_1/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency(policy/main_graph_0/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Goptimizer/gradients_1/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1MatMulnormalized_stateXoptimizer/gradients_1/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Ooptimizer/gradients_1/policy/main_graph_0/hidden_0/MatMul_grad/tuple/group_depsNoOpF^optimizer/gradients_1/policy/main_graph_0/hidden_0/MatMul_grad/MatMulH^optimizer/gradients_1/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1
�
Woptimizer/gradients_1/policy/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependencyIdentityEoptimizer/gradients_1/policy/main_graph_0/hidden_0/MatMul_grad/MatMulP^optimizer/gradients_1/policy/main_graph_0/hidden_0/MatMul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@optimizer/gradients_1/policy/main_graph_0/hidden_0/MatMul_grad/MatMul
�
Yoptimizer/gradients_1/policy/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependency_1IdentityGoptimizer/gradients_1/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1P^optimizer/gradients_1/policy/main_graph_0/hidden_0/MatMul_grad/tuple/group_deps*
T0*Z
_classP
NLloc:@optimizer/gradients_1/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1
�
#optimizer/beta1_power/initial_valueConst*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
dtype0*
valueB
 *fff?
�
optimizer/beta1_power
VariableV2*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
	container *
dtype0*
shape: *
shared_name 
�
optimizer/beta1_power/AssignAssignoptimizer/beta1_power#optimizer/beta1_power/initial_value*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
use_locking(*
validate_shape(
z
optimizer/beta1_power/readIdentityoptimizer/beta1_power*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias
�
#optimizer/beta2_power/initial_valueConst*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
dtype0*
valueB
 *w�?
�
optimizer/beta2_power
VariableV2*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
	container *
dtype0*
shape: *
shared_name 
�
optimizer/beta2_power/AssignAssignoptimizer/beta2_power#optimizer/beta2_power/initial_value*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
use_locking(*
validate_shape(
z
optimizer/beta2_power/readIdentityoptimizer/beta2_power*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias
�
Uoptimizer//policy/main_graph_0/hidden_0/kernel/Adam/Initializer/zeros/shape_as_tensorConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB"   �   
�
Koptimizer//policy/main_graph_0/hidden_0/kernel/Adam/Initializer/zeros/ConstConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB
 *    
�
Eoptimizer//policy/main_graph_0/hidden_0/kernel/Adam/Initializer/zerosFillUoptimizer//policy/main_graph_0/hidden_0/kernel/Adam/Initializer/zeros/shape_as_tensorKoptimizer//policy/main_graph_0/hidden_0/kernel/Adam/Initializer/zeros/Const*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*

index_type0
�
3optimizer//policy/main_graph_0/hidden_0/kernel/Adam
VariableV2*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
:optimizer//policy/main_graph_0/hidden_0/kernel/Adam/AssignAssign3optimizer//policy/main_graph_0/hidden_0/kernel/AdamEoptimizer//policy/main_graph_0/hidden_0/kernel/Adam/Initializer/zeros*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
8optimizer//policy/main_graph_0/hidden_0/kernel/Adam/readIdentity3optimizer//policy/main_graph_0/hidden_0/kernel/Adam*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel
�
Woptimizer//policy/main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB"   �   
�
Moptimizer//policy/main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros/ConstConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB
 *    
�
Goptimizer//policy/main_graph_0/hidden_0/kernel/Adam_1/Initializer/zerosFillWoptimizer//policy/main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros/shape_as_tensorMoptimizer//policy/main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros/Const*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*

index_type0
�
5optimizer//policy/main_graph_0/hidden_0/kernel/Adam_1
VariableV2*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
<optimizer//policy/main_graph_0/hidden_0/kernel/Adam_1/AssignAssign5optimizer//policy/main_graph_0/hidden_0/kernel/Adam_1Goptimizer//policy/main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
:optimizer//policy/main_graph_0/hidden_0/kernel/Adam_1/readIdentity5optimizer//policy/main_graph_0/hidden_0/kernel/Adam_1*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel
�
Coptimizer//policy/main_graph_0/hidden_0/bias/Adam/Initializer/zerosConst*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
dtype0*
valueB�*    
�
1optimizer//policy/main_graph_0/hidden_0/bias/Adam
VariableV2*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
	container *
dtype0*
shape:�*
shared_name 
�
8optimizer//policy/main_graph_0/hidden_0/bias/Adam/AssignAssign1optimizer//policy/main_graph_0/hidden_0/bias/AdamCoptimizer//policy/main_graph_0/hidden_0/bias/Adam/Initializer/zeros*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
6optimizer//policy/main_graph_0/hidden_0/bias/Adam/readIdentity1optimizer//policy/main_graph_0/hidden_0/bias/Adam*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias
�
Eoptimizer//policy/main_graph_0/hidden_0/bias/Adam_1/Initializer/zerosConst*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
dtype0*
valueB�*    
�
3optimizer//policy/main_graph_0/hidden_0/bias/Adam_1
VariableV2*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
	container *
dtype0*
shape:�*
shared_name 
�
:optimizer//policy/main_graph_0/hidden_0/bias/Adam_1/AssignAssign3optimizer//policy/main_graph_0/hidden_0/bias/Adam_1Eoptimizer//policy/main_graph_0/hidden_0/bias/Adam_1/Initializer/zeros*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
8optimizer//policy/main_graph_0/hidden_0/bias/Adam_1/readIdentity3optimizer//policy/main_graph_0/hidden_0/bias/Adam_1*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias
�
Uoptimizer//policy/main_graph_0/hidden_1/kernel/Adam/Initializer/zeros/shape_as_tensorConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB"�   �   
�
Koptimizer//policy/main_graph_0/hidden_1/kernel/Adam/Initializer/zeros/ConstConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB
 *    
�
Eoptimizer//policy/main_graph_0/hidden_1/kernel/Adam/Initializer/zerosFillUoptimizer//policy/main_graph_0/hidden_1/kernel/Adam/Initializer/zeros/shape_as_tensorKoptimizer//policy/main_graph_0/hidden_1/kernel/Adam/Initializer/zeros/Const*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*

index_type0
�
3optimizer//policy/main_graph_0/hidden_1/kernel/Adam
VariableV2*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
:optimizer//policy/main_graph_0/hidden_1/kernel/Adam/AssignAssign3optimizer//policy/main_graph_0/hidden_1/kernel/AdamEoptimizer//policy/main_graph_0/hidden_1/kernel/Adam/Initializer/zeros*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
8optimizer//policy/main_graph_0/hidden_1/kernel/Adam/readIdentity3optimizer//policy/main_graph_0/hidden_1/kernel/Adam*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel
�
Woptimizer//policy/main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB"�   �   
�
Moptimizer//policy/main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros/ConstConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB
 *    
�
Goptimizer//policy/main_graph_0/hidden_1/kernel/Adam_1/Initializer/zerosFillWoptimizer//policy/main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros/shape_as_tensorMoptimizer//policy/main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros/Const*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*

index_type0
�
5optimizer//policy/main_graph_0/hidden_1/kernel/Adam_1
VariableV2*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
<optimizer//policy/main_graph_0/hidden_1/kernel/Adam_1/AssignAssign5optimizer//policy/main_graph_0/hidden_1/kernel/Adam_1Goptimizer//policy/main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
:optimizer//policy/main_graph_0/hidden_1/kernel/Adam_1/readIdentity5optimizer//policy/main_graph_0/hidden_1/kernel/Adam_1*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel
�
Coptimizer//policy/main_graph_0/hidden_1/bias/Adam/Initializer/zerosConst*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
dtype0*
valueB�*    
�
1optimizer//policy/main_graph_0/hidden_1/bias/Adam
VariableV2*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
	container *
dtype0*
shape:�*
shared_name 
�
8optimizer//policy/main_graph_0/hidden_1/bias/Adam/AssignAssign1optimizer//policy/main_graph_0/hidden_1/bias/AdamCoptimizer//policy/main_graph_0/hidden_1/bias/Adam/Initializer/zeros*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
6optimizer//policy/main_graph_0/hidden_1/bias/Adam/readIdentity1optimizer//policy/main_graph_0/hidden_1/bias/Adam*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias
�
Eoptimizer//policy/main_graph_0/hidden_1/bias/Adam_1/Initializer/zerosConst*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
dtype0*
valueB�*    
�
3optimizer//policy/main_graph_0/hidden_1/bias/Adam_1
VariableV2*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
	container *
dtype0*
shape:�*
shared_name 
�
:optimizer//policy/main_graph_0/hidden_1/bias/Adam_1/AssignAssign3optimizer//policy/main_graph_0/hidden_1/bias/Adam_1Eoptimizer//policy/main_graph_0/hidden_1/bias/Adam_1/Initializer/zeros*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
8optimizer//policy/main_graph_0/hidden_1/bias/Adam_1/readIdentity3optimizer//policy/main_graph_0/hidden_1/bias/Adam_1*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias
�
5optimizer//policy/dense/kernel/Adam/Initializer/zerosConst*&
_class
loc:@policy/dense/kernel*
dtype0*
valueB	�*    
�
#optimizer//policy/dense/kernel/Adam
VariableV2*&
_class
loc:@policy/dense/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
*optimizer//policy/dense/kernel/Adam/AssignAssign#optimizer//policy/dense/kernel/Adam5optimizer//policy/dense/kernel/Adam/Initializer/zeros*
T0*&
_class
loc:@policy/dense/kernel*
use_locking(*
validate_shape(
�
(optimizer//policy/dense/kernel/Adam/readIdentity#optimizer//policy/dense/kernel/Adam*
T0*&
_class
loc:@policy/dense/kernel
�
7optimizer//policy/dense/kernel/Adam_1/Initializer/zerosConst*&
_class
loc:@policy/dense/kernel*
dtype0*
valueB	�*    
�
%optimizer//policy/dense/kernel/Adam_1
VariableV2*&
_class
loc:@policy/dense/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
,optimizer//policy/dense/kernel/Adam_1/AssignAssign%optimizer//policy/dense/kernel/Adam_17optimizer//policy/dense/kernel/Adam_1/Initializer/zeros*
T0*&
_class
loc:@policy/dense/kernel*
use_locking(*
validate_shape(
�
*optimizer//policy/dense/kernel/Adam_1/readIdentity%optimizer//policy/dense/kernel/Adam_1*
T0*&
_class
loc:@policy/dense/kernel
�
Yoptimizer//optimizer//main_graph_0/hidden_0/kernel/Adam/Initializer/zeros/shape_as_tensorConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
dtype0*
valueB"   �   
�
Ooptimizer//optimizer//main_graph_0/hidden_0/kernel/Adam/Initializer/zeros/ConstConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
dtype0*
valueB
 *    
�
Ioptimizer//optimizer//main_graph_0/hidden_0/kernel/Adam/Initializer/zerosFillYoptimizer//optimizer//main_graph_0/hidden_0/kernel/Adam/Initializer/zeros/shape_as_tensorOoptimizer//optimizer//main_graph_0/hidden_0/kernel/Adam/Initializer/zeros/Const*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*

index_type0
�
7optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam
VariableV2*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
>optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam/AssignAssign7optimizer//optimizer//main_graph_0/hidden_0/kernel/AdamIoptimizer//optimizer//main_graph_0/hidden_0/kernel/Adam/Initializer/zeros*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
<optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam/readIdentity7optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel
�
[optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
dtype0*
valueB"   �   
�
Qoptimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros/ConstConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
dtype0*
valueB
 *    
�
Koptimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1/Initializer/zerosFill[optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros/shape_as_tensorQoptimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros/Const*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*

index_type0
�
9optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1
VariableV2*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
@optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1/AssignAssign9optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1Koptimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
>optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1/readIdentity9optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel
�
Goptimizer//optimizer//main_graph_0/hidden_0/bias/Adam/Initializer/zerosConst*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
dtype0*
valueB�*    
�
5optimizer//optimizer//main_graph_0/hidden_0/bias/Adam
VariableV2*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
	container *
dtype0*
shape:�*
shared_name 
�
<optimizer//optimizer//main_graph_0/hidden_0/bias/Adam/AssignAssign5optimizer//optimizer//main_graph_0/hidden_0/bias/AdamGoptimizer//optimizer//main_graph_0/hidden_0/bias/Adam/Initializer/zeros*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
:optimizer//optimizer//main_graph_0/hidden_0/bias/Adam/readIdentity5optimizer//optimizer//main_graph_0/hidden_0/bias/Adam*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias
�
Ioptimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1/Initializer/zerosConst*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
dtype0*
valueB�*    
�
7optimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1
VariableV2*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
	container *
dtype0*
shape:�*
shared_name 
�
>optimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1/AssignAssign7optimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1Ioptimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1/Initializer/zeros*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
<optimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1/readIdentity7optimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias
�
Yoptimizer//optimizer//main_graph_0/hidden_1/kernel/Adam/Initializer/zeros/shape_as_tensorConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
dtype0*
valueB"�   �   
�
Ooptimizer//optimizer//main_graph_0/hidden_1/kernel/Adam/Initializer/zeros/ConstConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
dtype0*
valueB
 *    
�
Ioptimizer//optimizer//main_graph_0/hidden_1/kernel/Adam/Initializer/zerosFillYoptimizer//optimizer//main_graph_0/hidden_1/kernel/Adam/Initializer/zeros/shape_as_tensorOoptimizer//optimizer//main_graph_0/hidden_1/kernel/Adam/Initializer/zeros/Const*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*

index_type0
�
7optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam
VariableV2*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
>optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam/AssignAssign7optimizer//optimizer//main_graph_0/hidden_1/kernel/AdamIoptimizer//optimizer//main_graph_0/hidden_1/kernel/Adam/Initializer/zeros*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
<optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam/readIdentity7optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel
�
[optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
dtype0*
valueB"�   �   
�
Qoptimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros/ConstConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
dtype0*
valueB
 *    
�
Koptimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1/Initializer/zerosFill[optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros/shape_as_tensorQoptimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros/Const*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*

index_type0
�
9optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1
VariableV2*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
@optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1/AssignAssign9optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1Koptimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
>optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1/readIdentity9optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel
�
Goptimizer//optimizer//main_graph_0/hidden_1/bias/Adam/Initializer/zerosConst*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
dtype0*
valueB�*    
�
5optimizer//optimizer//main_graph_0/hidden_1/bias/Adam
VariableV2*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
	container *
dtype0*
shape:�*
shared_name 
�
<optimizer//optimizer//main_graph_0/hidden_1/bias/Adam/AssignAssign5optimizer//optimizer//main_graph_0/hidden_1/bias/AdamGoptimizer//optimizer//main_graph_0/hidden_1/bias/Adam/Initializer/zeros*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
:optimizer//optimizer//main_graph_0/hidden_1/bias/Adam/readIdentity5optimizer//optimizer//main_graph_0/hidden_1/bias/Adam*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias
�
Ioptimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1/Initializer/zerosConst*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
dtype0*
valueB�*    
�
7optimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1
VariableV2*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
	container *
dtype0*
shape:�*
shared_name 
�
>optimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1/AssignAssign7optimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1Ioptimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1/Initializer/zeros*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
<optimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1/readIdentity7optimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias
�
Coptimizer//optimizer//extrinsic_value/kernel/Adam/Initializer/zerosConst*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
dtype0*
valueB	�*    
�
1optimizer//optimizer//extrinsic_value/kernel/Adam
VariableV2*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
8optimizer//optimizer//extrinsic_value/kernel/Adam/AssignAssign1optimizer//optimizer//extrinsic_value/kernel/AdamCoptimizer//optimizer//extrinsic_value/kernel/Adam/Initializer/zeros*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
use_locking(*
validate_shape(
�
6optimizer//optimizer//extrinsic_value/kernel/Adam/readIdentity1optimizer//optimizer//extrinsic_value/kernel/Adam*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel
�
Eoptimizer//optimizer//extrinsic_value/kernel/Adam_1/Initializer/zerosConst*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
dtype0*
valueB	�*    
�
3optimizer//optimizer//extrinsic_value/kernel/Adam_1
VariableV2*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
:optimizer//optimizer//extrinsic_value/kernel/Adam_1/AssignAssign3optimizer//optimizer//extrinsic_value/kernel/Adam_1Eoptimizer//optimizer//extrinsic_value/kernel/Adam_1/Initializer/zeros*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
use_locking(*
validate_shape(
�
8optimizer//optimizer//extrinsic_value/kernel/Adam_1/readIdentity3optimizer//optimizer//extrinsic_value/kernel/Adam_1*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel
�
Aoptimizer//optimizer//extrinsic_value/bias/Adam/Initializer/zerosConst*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
dtype0*
valueB*    
�
/optimizer//optimizer//extrinsic_value/bias/Adam
VariableV2*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
	container *
dtype0*
shape:*
shared_name 
�
6optimizer//optimizer//extrinsic_value/bias/Adam/AssignAssign/optimizer//optimizer//extrinsic_value/bias/AdamAoptimizer//optimizer//extrinsic_value/bias/Adam/Initializer/zeros*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
use_locking(*
validate_shape(
�
4optimizer//optimizer//extrinsic_value/bias/Adam/readIdentity/optimizer//optimizer//extrinsic_value/bias/Adam*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias
�
Coptimizer//optimizer//extrinsic_value/bias/Adam_1/Initializer/zerosConst*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
dtype0*
valueB*    
�
1optimizer//optimizer//extrinsic_value/bias/Adam_1
VariableV2*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
	container *
dtype0*
shape:*
shared_name 
�
8optimizer//optimizer//extrinsic_value/bias/Adam_1/AssignAssign1optimizer//optimizer//extrinsic_value/bias/Adam_1Coptimizer//optimizer//extrinsic_value/bias/Adam_1/Initializer/zeros*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
use_locking(*
validate_shape(
�
6optimizer//optimizer//extrinsic_value/bias/Adam_1/readIdentity1optimizer//optimizer//extrinsic_value/bias/Adam_1*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias
A
optimizer/Adam/beta1Const*
dtype0*
valueB
 *fff?
A
optimizer/Adam/beta2Const*
dtype0*
valueB
 *w�?
C
optimizer/Adam/epsilonConst*
dtype0*
valueB
 *w�+2
�
Coptimizer/Adam/update_policy/main_graph_0/hidden_0/kernel/ApplyAdam	ApplyAdam#policy/main_graph_0/hidden_0/kernel3optimizer//policy/main_graph_0/hidden_0/kernel/Adam5optimizer//policy/main_graph_0/hidden_0/kernel/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/PolynomialDecayoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilonYoptimizer/gradients_1/policy/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependency_1*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking( *
use_nesterov( 
�
Aoptimizer/Adam/update_policy/main_graph_0/hidden_0/bias/ApplyAdam	ApplyAdam!policy/main_graph_0/hidden_0/bias1optimizer//policy/main_graph_0/hidden_0/bias/Adam3optimizer//policy/main_graph_0/hidden_0/bias/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/PolynomialDecayoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilonZoptimizer/gradients_1/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency_1*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking( *
use_nesterov( 
�
Coptimizer/Adam/update_policy/main_graph_0/hidden_1/kernel/ApplyAdam	ApplyAdam#policy/main_graph_0/hidden_1/kernel3optimizer//policy/main_graph_0/hidden_1/kernel/Adam5optimizer//policy/main_graph_0/hidden_1/kernel/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/PolynomialDecayoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilonYoptimizer/gradients_1/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency_1*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking( *
use_nesterov( 
�
Aoptimizer/Adam/update_policy/main_graph_0/hidden_1/bias/ApplyAdam	ApplyAdam!policy/main_graph_0/hidden_1/bias1optimizer//policy/main_graph_0/hidden_1/bias/Adam3optimizer//policy/main_graph_0/hidden_1/bias/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/PolynomialDecayoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilonZoptimizer/gradients_1/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency_1*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking( *
use_nesterov( 
�
3optimizer/Adam/update_policy/dense/kernel/ApplyAdam	ApplyAdampolicy/dense/kernel#optimizer//policy/dense/kernel/Adam%optimizer//policy/dense/kernel/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/PolynomialDecayoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilonKoptimizer/gradients_1/policy_1/dense/MatMul_grad/tuple/control_dependency_1*
T0*&
_class
loc:@policy/dense/kernel*
use_locking( *
use_nesterov( 
�
Goptimizer/Adam/update_optimizer//main_graph_0/hidden_0/kernel/ApplyAdam	ApplyAdam'optimizer//main_graph_0/hidden_0/kernel7optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam9optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/PolynomialDecayoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilon\optimizer/gradients_1/optimizer/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependency_1*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
use_locking( *
use_nesterov( 
�
Eoptimizer/Adam/update_optimizer//main_graph_0/hidden_0/bias/ApplyAdam	ApplyAdam%optimizer//main_graph_0/hidden_0/bias5optimizer//optimizer//main_graph_0/hidden_0/bias/Adam7optimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/PolynomialDecayoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilon]optimizer/gradients_1/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency_1*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
use_locking( *
use_nesterov( 
�
Goptimizer/Adam/update_optimizer//main_graph_0/hidden_1/kernel/ApplyAdam	ApplyAdam'optimizer//main_graph_0/hidden_1/kernel7optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam9optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/PolynomialDecayoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilon\optimizer/gradients_1/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency_1*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
use_locking( *
use_nesterov( 
�
Eoptimizer/Adam/update_optimizer//main_graph_0/hidden_1/bias/ApplyAdam	ApplyAdam%optimizer//main_graph_0/hidden_1/bias5optimizer//optimizer//main_graph_0/hidden_1/bias/Adam7optimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/PolynomialDecayoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilon]optimizer/gradients_1/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency_1*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
use_locking( *
use_nesterov( 
�
Aoptimizer/Adam/update_optimizer//extrinsic_value/kernel/ApplyAdam	ApplyAdam!optimizer//extrinsic_value/kernel1optimizer//optimizer//extrinsic_value/kernel/Adam3optimizer//optimizer//extrinsic_value/kernel/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/PolynomialDecayoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilonVoptimizer/gradients_1/optimizer/extrinsic_value/MatMul_grad/tuple/control_dependency_1*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
use_locking( *
use_nesterov( 
�
?optimizer/Adam/update_optimizer//extrinsic_value/bias/ApplyAdam	ApplyAdamoptimizer//extrinsic_value/bias/optimizer//optimizer//extrinsic_value/bias/Adam1optimizer//optimizer//extrinsic_value/bias/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/PolynomialDecayoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilonWoptimizer/gradients_1/optimizer/extrinsic_value/BiasAdd_grad/tuple/control_dependency_1*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
use_locking( *
use_nesterov( 
�
optimizer/Adam/mulMuloptimizer/beta1_power/readoptimizer/Adam/beta1@^optimizer/Adam/update_optimizer//extrinsic_value/bias/ApplyAdamB^optimizer/Adam/update_optimizer//extrinsic_value/kernel/ApplyAdamF^optimizer/Adam/update_optimizer//main_graph_0/hidden_0/bias/ApplyAdamH^optimizer/Adam/update_optimizer//main_graph_0/hidden_0/kernel/ApplyAdamF^optimizer/Adam/update_optimizer//main_graph_0/hidden_1/bias/ApplyAdamH^optimizer/Adam/update_optimizer//main_graph_0/hidden_1/kernel/ApplyAdam4^optimizer/Adam/update_policy/dense/kernel/ApplyAdamB^optimizer/Adam/update_policy/main_graph_0/hidden_0/bias/ApplyAdamD^optimizer/Adam/update_policy/main_graph_0/hidden_0/kernel/ApplyAdamB^optimizer/Adam/update_policy/main_graph_0/hidden_1/bias/ApplyAdamD^optimizer/Adam/update_policy/main_graph_0/hidden_1/kernel/ApplyAdam*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias
�
optimizer/Adam/AssignAssignoptimizer/beta1_poweroptimizer/Adam/mul*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
use_locking( *
validate_shape(
�
optimizer/Adam/mul_1Muloptimizer/beta2_power/readoptimizer/Adam/beta2@^optimizer/Adam/update_optimizer//extrinsic_value/bias/ApplyAdamB^optimizer/Adam/update_optimizer//extrinsic_value/kernel/ApplyAdamF^optimizer/Adam/update_optimizer//main_graph_0/hidden_0/bias/ApplyAdamH^optimizer/Adam/update_optimizer//main_graph_0/hidden_0/kernel/ApplyAdamF^optimizer/Adam/update_optimizer//main_graph_0/hidden_1/bias/ApplyAdamH^optimizer/Adam/update_optimizer//main_graph_0/hidden_1/kernel/ApplyAdam4^optimizer/Adam/update_policy/dense/kernel/ApplyAdamB^optimizer/Adam/update_policy/main_graph_0/hidden_0/bias/ApplyAdamD^optimizer/Adam/update_policy/main_graph_0/hidden_0/kernel/ApplyAdamB^optimizer/Adam/update_policy/main_graph_0/hidden_1/bias/ApplyAdamD^optimizer/Adam/update_policy/main_graph_0/hidden_1/kernel/ApplyAdam*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias
�
optimizer/Adam/Assign_1Assignoptimizer/beta2_poweroptimizer/Adam/mul_1*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
use_locking( *
validate_shape(
�
optimizer/AdamNoOp^optimizer/Adam/Assign^optimizer/Adam/Assign_1@^optimizer/Adam/update_optimizer//extrinsic_value/bias/ApplyAdamB^optimizer/Adam/update_optimizer//extrinsic_value/kernel/ApplyAdamF^optimizer/Adam/update_optimizer//main_graph_0/hidden_0/bias/ApplyAdamH^optimizer/Adam/update_optimizer//main_graph_0/hidden_0/kernel/ApplyAdamF^optimizer/Adam/update_optimizer//main_graph_0/hidden_1/bias/ApplyAdamH^optimizer/Adam/update_optimizer//main_graph_0/hidden_1/kernel/ApplyAdam4^optimizer/Adam/update_policy/dense/kernel/ApplyAdamB^optimizer/Adam/update_policy/main_graph_0/hidden_0/bias/ApplyAdamD^optimizer/Adam/update_policy/main_graph_0/hidden_0/kernel/ApplyAdamB^optimizer/Adam/update_policy/main_graph_0/hidden_1/bias/ApplyAdamD^optimizer/Adam/update_policy/main_graph_0/hidden_1/kernel/ApplyAdam
C
save_1/filename/inputConst*
dtype0*
valueB Bmodel
Z
save_1/filenamePlaceholderWithDefaultsave_1/filename/input*
dtype0*
shape: 
Q
save_1/ConstPlaceholderWithDefaultsave_1/filename*
dtype0*
shape: 
�
save_1/SaveV2/tensor_namesConst*
dtype0*�
value�B�.Baction_output_shapeBglobal_stepBis_continuous_controlBmemory_sizeBnormalization_stepsBoptimizer//extrinsic_value/biasB!optimizer//extrinsic_value/kernelB%optimizer//main_graph_0/hidden_0/biasB'optimizer//main_graph_0/hidden_0/kernelB%optimizer//main_graph_0/hidden_1/biasB'optimizer//main_graph_0/hidden_1/kernelB/optimizer//optimizer//extrinsic_value/bias/AdamB1optimizer//optimizer//extrinsic_value/bias/Adam_1B1optimizer//optimizer//extrinsic_value/kernel/AdamB3optimizer//optimizer//extrinsic_value/kernel/Adam_1B5optimizer//optimizer//main_graph_0/hidden_0/bias/AdamB7optimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1B7optimizer//optimizer//main_graph_0/hidden_0/kernel/AdamB9optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1B5optimizer//optimizer//main_graph_0/hidden_1/bias/AdamB7optimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1B7optimizer//optimizer//main_graph_0/hidden_1/kernel/AdamB9optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1B#optimizer//policy/dense/kernel/AdamB%optimizer//policy/dense/kernel/Adam_1B1optimizer//policy/main_graph_0/hidden_0/bias/AdamB3optimizer//policy/main_graph_0/hidden_0/bias/Adam_1B3optimizer//policy/main_graph_0/hidden_0/kernel/AdamB5optimizer//policy/main_graph_0/hidden_0/kernel/Adam_1B1optimizer//policy/main_graph_0/hidden_1/bias/AdamB3optimizer//policy/main_graph_0/hidden_1/bias/Adam_1B3optimizer//policy/main_graph_0/hidden_1/kernel/AdamB5optimizer//policy/main_graph_0/hidden_1/kernel/Adam_1Boptimizer/beta1_powerBoptimizer/beta2_powerBpolicy/dense/kernelB!policy/main_graph_0/hidden_0/biasB#policy/main_graph_0/hidden_0/kernelB!policy/main_graph_0/hidden_1/biasB#policy/main_graph_0/hidden_1/kernelBrunning_meanBrunning_varianceBtrainer_major_versionBtrainer_minor_versionBtrainer_patch_versionBversion_number
�
save_1/SaveV2/shape_and_slicesConst*
dtype0*o
valuefBd.B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B 
�
save_1/SaveV2SaveV2save_1/Constsave_1/SaveV2/tensor_namessave_1/SaveV2/shape_and_slicesaction_output_shapeglobal_stepis_continuous_controlmemory_sizenormalization_stepsoptimizer//extrinsic_value/bias!optimizer//extrinsic_value/kernel%optimizer//main_graph_0/hidden_0/bias'optimizer//main_graph_0/hidden_0/kernel%optimizer//main_graph_0/hidden_1/bias'optimizer//main_graph_0/hidden_1/kernel/optimizer//optimizer//extrinsic_value/bias/Adam1optimizer//optimizer//extrinsic_value/bias/Adam_11optimizer//optimizer//extrinsic_value/kernel/Adam3optimizer//optimizer//extrinsic_value/kernel/Adam_15optimizer//optimizer//main_graph_0/hidden_0/bias/Adam7optimizer//optimizer//main_graph_0/hidden_0/bias/Adam_17optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam9optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_15optimizer//optimizer//main_graph_0/hidden_1/bias/Adam7optimizer//optimizer//main_graph_0/hidden_1/bias/Adam_17optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam9optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1#optimizer//policy/dense/kernel/Adam%optimizer//policy/dense/kernel/Adam_11optimizer//policy/main_graph_0/hidden_0/bias/Adam3optimizer//policy/main_graph_0/hidden_0/bias/Adam_13optimizer//policy/main_graph_0/hidden_0/kernel/Adam5optimizer//policy/main_graph_0/hidden_0/kernel/Adam_11optimizer//policy/main_graph_0/hidden_1/bias/Adam3optimizer//policy/main_graph_0/hidden_1/bias/Adam_13optimizer//policy/main_graph_0/hidden_1/kernel/Adam5optimizer//policy/main_graph_0/hidden_1/kernel/Adam_1optimizer/beta1_poweroptimizer/beta2_powerpolicy/dense/kernel!policy/main_graph_0/hidden_0/bias#policy/main_graph_0/hidden_0/kernel!policy/main_graph_0/hidden_1/bias#policy/main_graph_0/hidden_1/kernelrunning_meanrunning_variancetrainer_major_versiontrainer_minor_versiontrainer_patch_versionversion_number*<
dtypes2
02.
m
save_1/control_dependencyIdentitysave_1/Const^save_1/SaveV2*
T0*
_class
loc:@save_1/Const
�
save_1/RestoreV2/tensor_namesConst"/device:CPU:0*
dtype0*�
value�B�.Baction_output_shapeBglobal_stepBis_continuous_controlBmemory_sizeBnormalization_stepsBoptimizer//extrinsic_value/biasB!optimizer//extrinsic_value/kernelB%optimizer//main_graph_0/hidden_0/biasB'optimizer//main_graph_0/hidden_0/kernelB%optimizer//main_graph_0/hidden_1/biasB'optimizer//main_graph_0/hidden_1/kernelB/optimizer//optimizer//extrinsic_value/bias/AdamB1optimizer//optimizer//extrinsic_value/bias/Adam_1B1optimizer//optimizer//extrinsic_value/kernel/AdamB3optimizer//optimizer//extrinsic_value/kernel/Adam_1B5optimizer//optimizer//main_graph_0/hidden_0/bias/AdamB7optimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1B7optimizer//optimizer//main_graph_0/hidden_0/kernel/AdamB9optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1B5optimizer//optimizer//main_graph_0/hidden_1/bias/AdamB7optimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1B7optimizer//optimizer//main_graph_0/hidden_1/kernel/AdamB9optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1B#optimizer//policy/dense/kernel/AdamB%optimizer//policy/dense/kernel/Adam_1B1optimizer//policy/main_graph_0/hidden_0/bias/AdamB3optimizer//policy/main_graph_0/hidden_0/bias/Adam_1B3optimizer//policy/main_graph_0/hidden_0/kernel/AdamB5optimizer//policy/main_graph_0/hidden_0/kernel/Adam_1B1optimizer//policy/main_graph_0/hidden_1/bias/AdamB3optimizer//policy/main_graph_0/hidden_1/bias/Adam_1B3optimizer//policy/main_graph_0/hidden_1/kernel/AdamB5optimizer//policy/main_graph_0/hidden_1/kernel/Adam_1Boptimizer/beta1_powerBoptimizer/beta2_powerBpolicy/dense/kernelB!policy/main_graph_0/hidden_0/biasB#policy/main_graph_0/hidden_0/kernelB!policy/main_graph_0/hidden_1/biasB#policy/main_graph_0/hidden_1/kernelBrunning_meanBrunning_varianceBtrainer_major_versionBtrainer_minor_versionBtrainer_patch_versionBversion_number
�
!save_1/RestoreV2/shape_and_slicesConst"/device:CPU:0*
dtype0*o
valuefBd.B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B 
�
save_1/RestoreV2	RestoreV2save_1/Constsave_1/RestoreV2/tensor_names!save_1/RestoreV2/shape_and_slices"/device:CPU:0*<
dtypes2
02.
�
save_1/AssignAssignaction_output_shapesave_1/RestoreV2*
T0*&
_class
loc:@action_output_shape*
use_locking(*
validate_shape(
�
save_1/Assign_1Assignglobal_stepsave_1/RestoreV2:1*
T0*
_class
loc:@global_step*
use_locking(*
validate_shape(
�
save_1/Assign_2Assignis_continuous_controlsave_1/RestoreV2:2*
T0*(
_class
loc:@is_continuous_control*
use_locking(*
validate_shape(
�
save_1/Assign_3Assignmemory_sizesave_1/RestoreV2:3*
T0*
_class
loc:@memory_size*
use_locking(*
validate_shape(
�
save_1/Assign_4Assignnormalization_stepssave_1/RestoreV2:4*
T0*&
_class
loc:@normalization_steps*
use_locking(*
validate_shape(
�
save_1/Assign_5Assignoptimizer//extrinsic_value/biassave_1/RestoreV2:5*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
use_locking(*
validate_shape(
�
save_1/Assign_6Assign!optimizer//extrinsic_value/kernelsave_1/RestoreV2:6*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_7Assign%optimizer//main_graph_0/hidden_0/biassave_1/RestoreV2:7*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
save_1/Assign_8Assign'optimizer//main_graph_0/hidden_0/kernelsave_1/RestoreV2:8*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_9Assign%optimizer//main_graph_0/hidden_1/biassave_1/RestoreV2:9*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_10Assign'optimizer//main_graph_0/hidden_1/kernelsave_1/RestoreV2:10*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_11Assign/optimizer//optimizer//extrinsic_value/bias/Adamsave_1/RestoreV2:11*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
use_locking(*
validate_shape(
�
save_1/Assign_12Assign1optimizer//optimizer//extrinsic_value/bias/Adam_1save_1/RestoreV2:12*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
use_locking(*
validate_shape(
�
save_1/Assign_13Assign1optimizer//optimizer//extrinsic_value/kernel/Adamsave_1/RestoreV2:13*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_14Assign3optimizer//optimizer//extrinsic_value/kernel/Adam_1save_1/RestoreV2:14*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_15Assign5optimizer//optimizer//main_graph_0/hidden_0/bias/Adamsave_1/RestoreV2:15*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
save_1/Assign_16Assign7optimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1save_1/RestoreV2:16*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
save_1/Assign_17Assign7optimizer//optimizer//main_graph_0/hidden_0/kernel/Adamsave_1/RestoreV2:17*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_18Assign9optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1save_1/RestoreV2:18*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_19Assign5optimizer//optimizer//main_graph_0/hidden_1/bias/Adamsave_1/RestoreV2:19*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_20Assign7optimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1save_1/RestoreV2:20*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_21Assign7optimizer//optimizer//main_graph_0/hidden_1/kernel/Adamsave_1/RestoreV2:21*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_22Assign9optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1save_1/RestoreV2:22*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_23Assign#optimizer//policy/dense/kernel/Adamsave_1/RestoreV2:23*
T0*&
_class
loc:@policy/dense/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_24Assign%optimizer//policy/dense/kernel/Adam_1save_1/RestoreV2:24*
T0*&
_class
loc:@policy/dense/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_25Assign1optimizer//policy/main_graph_0/hidden_0/bias/Adamsave_1/RestoreV2:25*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
save_1/Assign_26Assign3optimizer//policy/main_graph_0/hidden_0/bias/Adam_1save_1/RestoreV2:26*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
save_1/Assign_27Assign3optimizer//policy/main_graph_0/hidden_0/kernel/Adamsave_1/RestoreV2:27*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_28Assign5optimizer//policy/main_graph_0/hidden_0/kernel/Adam_1save_1/RestoreV2:28*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_29Assign1optimizer//policy/main_graph_0/hidden_1/bias/Adamsave_1/RestoreV2:29*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_30Assign3optimizer//policy/main_graph_0/hidden_1/bias/Adam_1save_1/RestoreV2:30*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_31Assign3optimizer//policy/main_graph_0/hidden_1/kernel/Adamsave_1/RestoreV2:31*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_32Assign5optimizer//policy/main_graph_0/hidden_1/kernel/Adam_1save_1/RestoreV2:32*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_33Assignoptimizer/beta1_powersave_1/RestoreV2:33*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
use_locking(*
validate_shape(
�
save_1/Assign_34Assignoptimizer/beta2_powersave_1/RestoreV2:34*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
use_locking(*
validate_shape(
�
save_1/Assign_35Assignpolicy/dense/kernelsave_1/RestoreV2:35*
T0*&
_class
loc:@policy/dense/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_36Assign!policy/main_graph_0/hidden_0/biassave_1/RestoreV2:36*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
save_1/Assign_37Assign#policy/main_graph_0/hidden_0/kernelsave_1/RestoreV2:37*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_38Assign!policy/main_graph_0/hidden_1/biassave_1/RestoreV2:38*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_39Assign#policy/main_graph_0/hidden_1/kernelsave_1/RestoreV2:39*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_40Assignrunning_meansave_1/RestoreV2:40*
T0*
_class
loc:@running_mean*
use_locking(*
validate_shape(
�
save_1/Assign_41Assignrunning_variancesave_1/RestoreV2:41*
T0*#
_class
loc:@running_variance*
use_locking(*
validate_shape(
�
save_1/Assign_42Assigntrainer_major_versionsave_1/RestoreV2:42*
T0*(
_class
loc:@trainer_major_version*
use_locking(*
validate_shape(
�
save_1/Assign_43Assigntrainer_minor_versionsave_1/RestoreV2:43*
T0*(
_class
loc:@trainer_minor_version*
use_locking(*
validate_shape(
�
save_1/Assign_44Assigntrainer_patch_versionsave_1/RestoreV2:44*
T0*(
_class
loc:@trainer_patch_version*
use_locking(*
validate_shape(
�
save_1/Assign_45Assignversion_numbersave_1/RestoreV2:45*
T0*!
_class
loc:@version_number*
use_locking(*
validate_shape(
�
save_1/restore_allNoOp^save_1/Assign^save_1/Assign_1^save_1/Assign_10^save_1/Assign_11^save_1/Assign_12^save_1/Assign_13^save_1/Assign_14^save_1/Assign_15^save_1/Assign_16^save_1/Assign_17^save_1/Assign_18^save_1/Assign_19^save_1/Assign_2^save_1/Assign_20^save_1/Assign_21^save_1/Assign_22^save_1/Assign_23^save_1/Assign_24^save_1/Assign_25^save_1/Assign_26^save_1/Assign_27^save_1/Assign_28^save_1/Assign_29^save_1/Assign_3^save_1/Assign_30^save_1/Assign_31^save_1/Assign_32^save_1/Assign_33^save_1/Assign_34^save_1/Assign_35^save_1/Assign_36^save_1/Assign_37^save_1/Assign_38^save_1/Assign_39^save_1/Assign_4^save_1/Assign_40^save_1/Assign_41^save_1/Assign_42^save_1/Assign_43^save_1/Assign_44^save_1/Assign_45^save_1/Assign_5^save_1/Assign_6^save_1/Assign_7^save_1/Assign_8^save_1/Assign_9
�
init_1NoOp^action_output_shape/Assign^global_step/Assign^is_continuous_control/Assign^memory_size/Assign^normalization_steps/Assign'^optimizer//extrinsic_value/bias/Assign)^optimizer//extrinsic_value/kernel/Assign-^optimizer//main_graph_0/hidden_0/bias/Assign/^optimizer//main_graph_0/hidden_0/kernel/Assign-^optimizer//main_graph_0/hidden_1/bias/Assign/^optimizer//main_graph_0/hidden_1/kernel/Assign7^optimizer//optimizer//extrinsic_value/bias/Adam/Assign9^optimizer//optimizer//extrinsic_value/bias/Adam_1/Assign9^optimizer//optimizer//extrinsic_value/kernel/Adam/Assign;^optimizer//optimizer//extrinsic_value/kernel/Adam_1/Assign=^optimizer//optimizer//main_graph_0/hidden_0/bias/Adam/Assign?^optimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1/Assign?^optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam/AssignA^optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1/Assign=^optimizer//optimizer//main_graph_0/hidden_1/bias/Adam/Assign?^optimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1/Assign?^optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam/AssignA^optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1/Assign+^optimizer//policy/dense/kernel/Adam/Assign-^optimizer//policy/dense/kernel/Adam_1/Assign9^optimizer//policy/main_graph_0/hidden_0/bias/Adam/Assign;^optimizer//policy/main_graph_0/hidden_0/bias/Adam_1/Assign;^optimizer//policy/main_graph_0/hidden_0/kernel/Adam/Assign=^optimizer//policy/main_graph_0/hidden_0/kernel/Adam_1/Assign9^optimizer//policy/main_graph_0/hidden_1/bias/Adam/Assign;^optimizer//policy/main_graph_0/hidden_1/bias/Adam_1/Assign;^optimizer//policy/main_graph_0/hidden_1/kernel/Adam/Assign=^optimizer//policy/main_graph_0/hidden_1/kernel/Adam_1/Assign^optimizer/beta1_power/Assign^optimizer/beta2_power/Assign^policy/dense/kernel/Assign)^policy/main_graph_0/hidden_0/bias/Assign+^policy/main_graph_0/hidden_0/kernel/Assign)^policy/main_graph_0/hidden_1/bias/Assign+^policy/main_graph_0/hidden_1/kernel/Assign^running_mean/Assign^running_variance/Assign^trainer_major_version/Assign^trainer_minor_version/Assign^trainer_patch_version/Assign^version_number/Assign"�