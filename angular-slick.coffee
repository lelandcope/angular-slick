angular.module('angular-slick', [])
    .directive 'slick', [
        '$timeout'

        ($timeout)->
            restrict: 'AEC'
            scope:
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

                        slider.slick('unslick')
                        slider.find('.slick-list').remove()
                        
                        return slider

                initializeSlick = ->
                    $timeout ->
                        slider = $ elem
                        customPaging = undefined

                        if attrs.customPaging
                            customPaging = (slick, index)->
                                $scope.customPaging { slick: slick, index: index }

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
                            customPaging: customPaging
                            dots: $scope.dots is 'true'
                            draggable: $scope.draggable isnt 'false'
                            fade: $scope.fade is 'true'
                            focusOnSelect: $scope.focusOnSelect is 'true'
                            easing: $scope.easing or 'linear'
                            edgeFriction: Number($scope.edgeFriction or 0.15)
                            infinite: $scope.infinite isnt 'false'
                            initialSlide:$scope.initialSlide or 0
                            lazyLoad: $scope.lazyLoad or 'ondemand'
                            mobileFirst: $scope.mobileFirst is 'true'
                            pauseOnHover: $scope.pauseOnHover isnt 'false'
                            pauseOnDotsHover: $scope.pauseOnDotsHover is 'true'
                            respondTo: $scope.respondTo or 'window'
                            responsive: $scope.responsive or undefined
                            slide: $scope.slide or 'div'
                            slidesToShow: if $scope.slidesToShow? then parseInt($scope.slidesToShow, 10) else 1
                            slidesToScroll: if $scope.slidesToScroll? then parseInt($scope.slidesToScroll, 10) else 1
                            speed: if $scope.speed? then parseInt($scope.speed, 10) else 300
                            swipe: $scope.swipe isnt 'false'
                            swipeToSlide: $scope.swipeToSlide is 'true'
                            touchMove: $scope.touchMove isnt 'false'
                            touchThreshold: if $scope.touchThreshold then parseInt($scope.touchThreshold, 10) else 5
                            useCSS: $scope.useCSS isnt 'false'
                            variableWidth: $scope.variableWidth is 'true'
                            vertical: $scope.vertical is 'true'
                            rtl: $scope.rtl is 'true'

                        # Events
                        slider.on 'afterChange', (e, slick, index)->
                            $scope.onAfterChange(
                                event: e
                                slick: slick
                                index: index
                            ) if attrs.onAfterChange

                            if $scope.currentIndex?
                                $scope.$apply ->
                                    $scope.currentIndex = index

                        slider.on 'beforeChange', (e, slick, currentIndex, nextIndex)->
                            $scope.onBeforeChange(
                                event: e
                                slick: slick
                                currentIndex: currentIndex
                                nextIndex: nextIndex
                            ) if attrs.onBeforeChange

                        slider.on 'edge', (e, slick, direction)->
                            $scope.onEdge(
                                event: e
                                slick: slick
                                direction: direction
                            ) if attrs.onEdge

                        slider.on 'init', (e, slick)->
                            $scope.onInit(
                                event: e
                                slick: slick
                            ) if attrs.onInit

                        slider.on 'reInit', (e, slick)->
                            $scope.onReinit(
                                event: e
                                slick: slick
                            ) if attrs.onReinit

                        slider.on 'setPosition', (e, slick)->
                            $scope.onSetPosition(
                                event: e
                                slick: slick
                            ) if attrs.onSetPosition

                        slider.on 'swipe', (e, slick, direction)->
                            $scope.onSwipe(
                                event: e
                                slick: slick
                                direction: direction
                            ) if attrs.onSwipe

                        # Watch Functions
                        $scope.$watch 'currentIndex', (newValue, oldValue)->
                            if newValue? and newValue isnt oldValue
                                slider.slick 'slickGoTo', newValue


                if $scope.initOnload
                    isInitialized = false

                    $scope.$watch 'data', (newVal, oldVal)->
                        if newVal?
                            destroySlick() if isInitialized
                            initializeSlick()
                            isInitialized = true
                else
                    initializeSlick()

                # On Destroy
                $scope.$on '$destroy', ->
                    destroySlick()
    ]