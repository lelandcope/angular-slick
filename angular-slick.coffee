angular.module('angular-slick', [])
    .directive 'slick', [
        '$timeout'

        ($timeout)->
            restrict: 'AEC'
            $scope:
                initOnload: "@"
                data: "="
                currentIndex: "="

                # Properties
                accessibility: "@"
                adaptiveHeight: "@"
                autoplay: "@"
                autoplaySpeed: "@"
                arrows: "@"
                asNavFor: "@"
                appendArrows: "@"
                prevArrow: "@"
                nextArrow: "@"
                centerMode: "@"
                centerPadding: "@"
                cssEase: "@"
                customPaging: "&"
                dots: "@"
                draggable: "@"
                fade: "@"
                focusOnSelect: "@"
                easing: "@"
                edgeFriction: "@"
                infinite: "@"
                initialSlide: "@"
                lazyLoad: "@"
                mobileFirst: "@"
                pauseOnHover: "@"
                pauseOnDotsHover: "@"
                respondTo: "@"
                responsive: "="
                slide: "@"
                slidesToShow: "@"
                slidesToScroll: "@"
                speed: "@"
                swipe: "@"
                swipeToSlide: "@"
                touchMove: "@"
                touchThreshold: "@"
                useCSS: "@"
                variableWidth: "@"
                vertical: "@"
                rtl: "@"

                # Events
                onAfterChange: '&'
                onBeforeChange: '&'
                onEdge: '&'
                onInit: '&'
                onReInit: '&'
                onSetPosition: '&'
                onSwipe: '&'

            link: ($scope, elem, attrs)->
                destroySlick = ->
                    $timeout ->
                        slider = $(elem)

                        slider.unslick()
                        slider.find('.slick-list').remove()
                        
                        return slider

                initializeSlick = ->
                    $timeout ->
                        slider       = $ elem
                        currentIndex = $scope.currentIndex if $scope.currentIndex?

                        slider.slick
                            accessibility: $scope.accessibility isnt 'false'
                            adaptiveHeight: $scope.adaptiveHeight is 'true'
                            autoplay: $scope.autoplay is 'true'
                            autoplaySpeed: if $scope.autoplaySpeed? then parseInt($scope.autoplaySpeed, 10) else 3000
                            arrows: $scope.arrows isnt 'false'
                            asNavFor: if $scope.asNavFor then $scope.asNavFor else undefined
                            appendArrows: if $scope.appendArrows then $($scope.appendArrows) else $(elem)
                            prevArrow: if $scope.prevArrow then $($scope.prevArrow) else undefined
                            nextArrow: if $scope.nextArrow then $($scope.nextArrow) else undefined
                            centerMode: $scope.centerMode is 'true'
                            centerPadding: $scope.centerPadding or '50px'
                            cssEase: $scope.cssEase or 'ease'
                            customPaging: if attrs.customPaging then $scope.customPaging else undefined
                            dots: $scope.dots is 'true'
                            draggable: $scope.draggable isnt 'false'
                            fade: $scope.fade is 'true'
                            focusOnSelect: $scope.focusOnSelect is 'true'
                            easing: $scope.easing or 'linear'
                            edgeFriction: Number($scope.edgeFriction or 0.15)
                            infinite: $scope.infinite isnt 'false'
                            initialSlide: $scope.initialSlide or 0
                            lazyLoad: $scope.lazyLoad or 'ondemand'
                            mobileFirst: $scope.mobileFirst is 'true'
                            pauseOnHover: $scope.pauseOnHover isnt 'false'
                            pauseOnDotsHover: $scope.pauseOnDotsHover is 'true'
                            respondTo: $scope.respondTo or 'window'
                            responsive: $scope.responsive or undefined
                            slide: $scope.slide or 'div'
                            slidesToShow: Number($scope.slidesToShow or 1)
                            slidesToScroll: Number($scope.slidesToScroll or 1)
                            speed: Number($scope.speed or 300)
                            swipe: $scope.swipe is 'true'
                            swipeToSlide: $scope.swipeToSlide isnt 'false'
                            touchMove: $scope.touchMove is 'true'
                            touchThreshold: Number($scope.touchThreshold or 5)
                            useCSS: $scope.useCSS is 'true'
                            variableWidth: $scope.variableWidth isnt 'false'
                            vertical: $scope.vertical isnt 'false'
                            rtl: $scope.rtl isnt 'false'

                        slider.on 'afterChange', (e, slick, currentSlide)->
                            #$scope.currentIndex =
                            console.log currentSlide

                        $scope.$watch 'currentIndex', (newValue, oldValue)->
                            if newValue? and newValue isnt oldValue
                                slider.slickGoTo newValue


                if $scope.initOnload
                    isInitialized = false

                    $scope.$watch 'data', (newVal, oldVal)->
                        if newVal?
                            destroySlick() if isInitialized
                            initializeSlick()
                            isInitialized = true
                else
                    initializeSlick()

                $scope.$on '$destroy', ->
                    destroySlick()
    ]