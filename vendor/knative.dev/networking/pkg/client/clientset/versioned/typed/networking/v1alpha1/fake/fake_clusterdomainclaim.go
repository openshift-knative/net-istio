/*
Copyright 2020 The Knative Authors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

// Code generated by client-gen. DO NOT EDIT.

package fake

import (
	gentype "k8s.io/client-go/gentype"
	v1alpha1 "knative.dev/networking/pkg/apis/networking/v1alpha1"
	networkingv1alpha1 "knative.dev/networking/pkg/client/clientset/versioned/typed/networking/v1alpha1"
)

// fakeClusterDomainClaims implements ClusterDomainClaimInterface
type fakeClusterDomainClaims struct {
	*gentype.FakeClientWithList[*v1alpha1.ClusterDomainClaim, *v1alpha1.ClusterDomainClaimList]
	Fake *FakeNetworkingV1alpha1
}

func newFakeClusterDomainClaims(fake *FakeNetworkingV1alpha1) networkingv1alpha1.ClusterDomainClaimInterface {
	return &fakeClusterDomainClaims{
		gentype.NewFakeClientWithList[*v1alpha1.ClusterDomainClaim, *v1alpha1.ClusterDomainClaimList](
			fake.Fake,
			"",
			v1alpha1.SchemeGroupVersion.WithResource("clusterdomainclaims"),
			v1alpha1.SchemeGroupVersion.WithKind("ClusterDomainClaim"),
			func() *v1alpha1.ClusterDomainClaim { return &v1alpha1.ClusterDomainClaim{} },
			func() *v1alpha1.ClusterDomainClaimList { return &v1alpha1.ClusterDomainClaimList{} },
			func(dst, src *v1alpha1.ClusterDomainClaimList) { dst.ListMeta = src.ListMeta },
			func(list *v1alpha1.ClusterDomainClaimList) []*v1alpha1.ClusterDomainClaim {
				return gentype.ToPointerSlice(list.Items)
			},
			func(list *v1alpha1.ClusterDomainClaimList, items []*v1alpha1.ClusterDomainClaim) {
				list.Items = gentype.FromPointerSlice(items)
			},
		),
		fake,
	}
}
